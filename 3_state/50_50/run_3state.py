import os
import sys
import math
import copy

if sys.platform=="cygwin":
    from cyglibra_core import *
elif sys.platform=="linux" or sys.platform=="linux2":
    from liblibra_core import *

from libra_py import units
import libra_py.workflows.nbra.step4 as step4

nsteps = 150000
ntrajs = 1000
e0 = 0.0
e1 = 0.001
e2 = 0.002

dt = 0.1*units.fs2au

V01, V12 = e1-e0, e2-e1
V02 = 0.0

#h = open("_bz_temp.txt","w")
#h.write("%8.5f %8.5f\n" % (de/units.kB, 0.0))
#h.write("%8.5f %8.5f\n" % (de/units.kB, 100.0)); h.close()

# Populate Hvib - this is our model
Hvib, hvib = [], []
for i in xrange(nsteps):
    hvib.append(CMATRIX(3,3))
    hvib[i].set(0,0,-e0+0.0j);         hvib[i].set(0,1, V01*(0.0+1.0j));  hvib[i].set(0,2, V02*(0.0+1.0j));
    hvib[i].set(1,0, V01*(0.0-1.0j));  hvib[i].set(1,1, e1+0.0j);         hvib[i].set(1,2, V12*(0.0+1.0j));
    hvib[i].set(2,0, V02*(0.0-1.0j));  hvib[i].set(2,1, V12*(0.0-1.0j));  hvib[i].set(2,2, e2+0.0j);
Hvib.append(hvib)

istate = 2

params = {}

decos      = [2,3]
bz_schemes = [0,1,2]
temps      = [300.0]

for deco in decos:

    deco_time = 0.0
    # If using mSDM or DISH, set manual decoherence times
    if deco == 2 or deco == 3:

        tau = MATRIX(3,3)

        t12 = 50.0 * units.fs2au
        t01 = 50.0 * units.fs2au
        t02 = 0.0 * units.fs2au

        tau.set(0, 1, t01); tau.set(0, 2, t02);
        tau.set(1, 0, t01); tau.set(1, 2, t12);
        tau.set(2, 0, t02); tau.set(2, 1, t12);

        deco_time = tau.get(1,2) / units.fs2au

        params["decoherence_constants"] = 1
        params["decoherence_times"] = tau

    else:
        params["decoherence_constants"] = 0

    for bz_scheme in bz_schemes:

        g = open("_res_"+str(deco)+str(bz_scheme)+"_"+str(deco_time)+".txt","w");g.close()

        # For NA-MD Temperature
        for temp in temps:

            # Update params
            params.update({"T":temp, "ntraj":ntrajs, "sh_method":1, "decoherence_method":deco, "dt":dt})
            params.update({"nsteps":nsteps, "Boltz_opt":bz_scheme})
            params.update({"istate":istate, "init_times":[0], "outfile":"_tmp"+str(deco)+str(bz_scheme)+"_"+str(deco_time)+".txt"})
            params.update({"data_set_paths":[""]})


            # Run Dynamics
            res = step4.run(Hvib, params)

            # Begin Analysis
            t = []
            shE, shP0, shP1, shP2 = [], [], [], []
            seE, seP0, seP1, seP2 = [], [], [], []

            numer, denom = 0.0, 0.0
            for i in xrange(Hvib[0][0].num_of_rows):
                Ei = Hvib[0][0].get(i,i).real   
                numer +=  math.exp( - Ei / (units.kB*temp) ) * Ei
                denom +=  math.exp( - Ei / (units.kB*temp) )

            P0_eq = math.exp( -Hvib[0][0].get(0,0).real / (units.kB*temp) ) / denom
            P1_eq = math.exp( -Hvib[0][0].get(1,1).real / (units.kB*temp) ) / denom
            P2_eq = math.exp( -Hvib[0][0].get(2,2).real / (units.kB*temp) ) / denom

            boltz_fact_10 = 0.0 #math.exp(-de/(units.kB*temp))  
            boltz_fact_20 = 0.0 #math.exp(-2.0*de/(units.kB*temp))
            boltz_en = numer / denom

            print "\nPopulation of states at equilibirum = "
            print "P0_eq = ", P0_eq
            print "P1_eq = ", P1_eq
            print "P2_eq = ", P2_eq
            print "Check: P0_eq + P1_eq + P2_eq = ", P0_eq + P1_eq + P2_eq 
            #sys.exit(0)  
  
            sh0_avg, sh1_avg, sh2_avg = 0.0, 0.0, 0.0
            se0_avg, se1_avg, se2_avg = 0.0, 0.0, 0.0

            #"""   
            f = open("_out_"+str(deco)+"_"+str(bz_scheme)+"_"+str(temp)+"_"+str(deco_time)+".txt","w")
            for i in xrange(nsteps):

                t.append(res.get(i, 0))  # time

                shE.append(res.get(i, 8))   # SH-weighted enegy
                shP0.append(res.get(i, 3))  # SH pop of state 0
                shP1.append(res.get(i, 6))  # SH pop of state 1  
                shP2.append(res.get(i, 9))  # SH pop of state 2            

                seE.append(res.get(i, 7))   # SE-weighted energy
                seP0.append(res.get(i, 2))  # SE pop of state 0
                seP1.append(res.get(i, 5))  # SE pop of state 1
                seP2.append(res.get(i, 8))  # SE pop of state 2

                if i >= 9*nsteps/10:
                
                    sh0_avg += res.get(i, 3)
                    sh1_avg += res.get(i, 6)
                    sh2_avg += res.get(i, 9)

                    se0_avg += res.get(i, 2)
                    se1_avg += res.get(i, 5)
                    se2_avg += res.get(i, 8)

                f.write("%s  %s  %s  %s  %8.5f  %8.5f  %8.5f  %8.5f\n" % (t[i], shE[i], shP0[i], shP1[i], shP2[i], P0_eq, P1_eq, P2_eq))
            f.close()        

            # Compute average pops
            state0_avg = sum(shP0)/nsteps
            state1_avg = sum(shP1)/nsteps
            state2_avg = sum(shP2)/nsteps

            # Compute average pops past Eq. point
            sh0_avg /= nsteps/10
            sh1_avg /= nsteps/10
            sh2_avg /= nsteps/10

            se0_avg /= nsteps/10
            se1_avg /= nsteps/10
            se2_avg /= nsteps/10

            print "\nWe are doing, ", "T = ", temp, "Deco_method = ", deco
            print "Manually decohherence times = ", deco_time
            print "We are treating frustrated hops using scheme: ", bz_scheme
            print "P0_calc = ", sh0_avg, "whole t avg = ", state0_avg
            print "P1_calc = ", sh1_avg, "whole t avg = ", state1_avg
            print "P2_calc = ", sh2_avg, "whole t avg = ", state2_avg
            print "Expected Boltzman populations factor, total pop on state 1 / total pot on stat 0 ", boltz_fact_10
            print "Expected Boltzman populations factor, total pop on state 2 / total pot on stat 0 ", boltz_fact_20
            sh_ratio_21 = sh2_avg / sh1_avg  #shP1[nsteps-1]/shP0[nsteps-1]
            se_ratio_21 = se2_avg / se1_avg  #seP1[nsteps-1]/seP0[nsteps-1]
            sh_ratio_10 = sh1_avg / sh0_avg  #shP1[nsteps-1]/shP0[nsteps-1]
            se_ratio_10 = se1_avg / se0_avg  #seP1[nsteps-1]/seP0[nsteps-1]

            g = open("_res_"+str(deco)+str(bz_scheme)+"_"+str(deco_time)+".txt","a")
            g.write("%s  %s  %s  %8.5f  %8.5f  %8.5f\n" % (temp, sh_ratio_10, sh_ratio_21, boltz_fact_10, boltz_fact_20, boltz_en))
            g.close()          
            #"""

