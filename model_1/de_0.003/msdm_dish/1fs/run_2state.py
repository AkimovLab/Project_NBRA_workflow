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

dt = 0.1*units.fs2au
nsteps = 10000
ntrajs = 1000
de  = 0.003
V01 = 0.003

h = open("_bz_temp.txt","w")
h.write("%8.5f %8.5f\n" % (de/units.kB, 0.0))
h.write("%8.5f %8.5f\n" % (de/units.kB, 100.0)); h.close()

# Populate Hvib - this is our model
Hvib, hvib = [], []
for i in xrange(nsteps):
    hvib.append(CMATRIX(2,2))
    hvib[i].set(0,0,-0.000+0.0j);     hvib[i].set(0,1, V01*(0.0+1.0j));
    hvib[i].set(1,0, V01*(0.0-1.0j)); hvib[i].set(1,1, de+0.0j);
Hvib.append(hvib)



params = {}

decos      = [2,3]
bz_schemes = [0,1,2]
temps      = [100.0*k for k in xrange(1,11)]


for deco in decos:

    deco_time = 0.0
    # If using mSDM or DISH, set manual decoherence times
    if deco == 2 or deco == 3:
        deco_time = 1.0
        tau = MATRIX(2,2)
        t01 = deco_time * units.fs2au
        tau.set(0, 1, t01)
        tau.set(1, 0, t01)
        params["decoherence_constants"] = 1
        params["decoherence_times"] = tau

    else:
        params["decoherence_constants"] = 0

    for bz_scheme in bz_schemes:

        g = open("_res_"+str(deco)+str(bz_scheme)+"_"+str(deco_time)+".txt","w");g.close()

        # For NA-MD Temperature
        for temp in temps:

            # Update params
            params.update({"T":temp, "ntraj":ntrajs, "sh_method":0, "decoherence_method":deco, "dt":dt})
            params.update({"nsteps":nsteps, "Boltz_opt":bz_scheme})
            params.update({"istate":1, "init_times":[0], "outfile":"_tmp_"+str(deco)+str(bz_scheme)+"_"+str(temp)+"_"+str(deco_time)+".txt"})
            params.update({"data_set_paths":[""]})

            # Run Dynamics
            res = step4.run(Hvib, params)

            # Begin Analysis
            t = []
            shE, shP0, shP1 = [], [], []
            seE, seP0, seP1 = [], [], []

            numer, denom = 0.0, 0.0
            for i in xrange(Hvib[0][0].num_of_rows):
                Ei = Hvib[0][0].get(i,i).real    # energy is constant, so the average energy is the same as the initial
                numer +=  math.exp( - Ei / (units.kB*temp) ) * Ei
                denom +=  math.exp( - Ei / (units.kB*temp) )
            boltz_en = numer / denom
            boltz_fact_10 = math.exp(-de/(units.kB*temp))

            P0_eq = math.exp( -Hvib[0][0].get(0,0).real / (units.kB*temp) ) / denom
            P1_eq = math.exp( -Hvib[0][0].get(1,1).real / (units.kB*temp) ) / denom

            print "\nPopulation of states at equilibirum for Temp", temp, " = "
            print "P0_eq = ", P0_eq
            print "P1_eq = ", P1_eq
            print "Check: P0_eq + P1_eq = ", P0_eq + P1_eq 

            sh0_avg, sh1_avg = 0.0, 0.0
            se0_avg, se1_avg = 0.0, 0.0

            #"""   
            f = open("_out_"+str(deco)+"_"+str(bz_scheme)+"_"+str(temp)+"_"+str(deco_time)+".txt","w")
            for i in xrange(nsteps):

                t.append(res.get(i, 0))  # time

                shE.append(res.get(i, 8))   # SH-weighted enegy
                shP0.append(res.get(i, 3))  # SH pop of state 0
                shP1.append(res.get(i, 6))  # SH pop of state 1  
            
                seE.append(res.get(i, 7))   # SE-weighted energy
                seP0.append(res.get(i, 2))  # SE pop of state 0
                seP1.append(res.get(i, 5))  # SE pop of state 1

                if i >= 9*nsteps/10:
                
                    sh0_avg += res.get(i, 3)
                    sh1_avg += res.get(i, 6)

                    se0_avg += res.get(i, 2)
                    se1_avg += res.get(i, 5)

                f.write("%s  %s  %s  %s  %8.5f\n" % (t[i], shE[i], shP0[i], shP1[i], P1_eq))
            f.close()        

            # Compute average pops past Eq. point
            sh0_avg /= nsteps/10
            sh1_avg /= nsteps/10
            se0_avg /= nsteps/10
            se1_avg /= nsteps/10

            # Compute average pops
            state0_avg = sum(shP0)/nsteps
            state1_avg = sum(shP1)/nsteps

            print "\nWe are doing, ", "T = ", temp, "Deco_method = ", deco
            print "Manually decohherence times = ", deco_time
            print "We are treating frustrated hops using scheme: ", bz_scheme
            print "Last 1/10 avg for Eq. = ", sh0_avg, "Full avg = ", state0_avg
            print "Last 1/10 avg for Eq. = ", sh1_avg, "Full avg = ", state1_avg
 
            #print "Expected Boltzman populations factor, total pop on state 1 / total pot on stat 0 ", boltz_pop
            sh_ratio = sh1_avg / sh0_avg  #shP1[nsteps-1]/shP0[nsteps-1]
            se_ratio = se1_avg / se0_avg  #seP1[nsteps-1]/seP0[nsteps-1]
            print "actual ratio of the SH populations on the two states, at equilibrium = ", sh_ratio
            print "actual ratio of the SE populations on the two states, at equilibrium = ", se_ratio

            g = open("_res_"+str(deco)+str(bz_scheme)+"_"+str(deco_time)+".txt","a")
            g.write("%s  %s  %8.5f  %8.5f\n" % (temp, sh_ratio, boltz_fact_10, boltz_en))
            g.close()          
            #"""

