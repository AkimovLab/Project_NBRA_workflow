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
import libra_py.workflows.nbra.decoherence_times as decoherence_times

nsteps = 100000
ntrajs = 1000

# Make Hamiltonian for each time step
rnd = Random()

de = 0.1 * units.ev2Ha
h = open("_bz_temp.txt","w")
h.write("%8.5f %8.5f\n" % (de/units.kB, 0.0))
h.write("%8.5f %8.5f\n" % (de/units.kB, 100.0)); h.close()

w0 = 1800.0 * units.inv_cm2Ha  # in cm^-1
w1 = 1500.0 * units.inv_cm2Ha  # in cm^-1
w2 = 1300.0 * units.inv_cm2Ha  # in cm^-1

w3 = 800.0 * units.inv_cm2Ha  # in cm^-1
w4 = 500.0 * units.inv_cm2Ha  # in cm^-1
w5 = 300.0 * units.inv_cm2Ha  # in cm^-1

wd = 1000.0 * units.inv_cm2Ha  # in cm^-1

dt = 0.1 * units.fs2au

# Populate Hvib - this is our model
Hvib = []
hvib = []

m = open("_energy.txt","w"); m.close()
for i in xrange(nsteps):        
    hvib.append(CMATRIX(2,2))
    
    t = dt*i

    e0 = 0.0003*(math.sin(0.7*w0*t + 0.3) + math.sin(0.6*w1*t + 0.2) + math.sin(0.7*w2*t + 0.7) + math.sin(0.7*w3*t + 0.3) + math.sin(w4*t + 0.5) + math.sin(w5*t + 0.7) )
    e1 = 0.0003*(math.sin(w0*t)           + math.sin(w1*t)           + math.sin(0.5*w2*t)       + math.sin(0.4*w3*t)       + math.sin(w4*t)       + math.sin(w5*t) )
    e1 += de
    d  = (e1-e0)

    hvib[i].set(0,0,e0*(1.0+0.0j));   hvib[i].set(0,1, d*(0.0-1.0j));
    hvib[i].set(1,0, d*(0.0+1.0j));   hvib[i].set(1,1, e1*(1.0+0.0j));

    m = open("_energy.txt","a")
    m.write("%8.5f  %8.5f  %8.5f  %8.5f\n" % (t, e0/units.ev2Ha, e1/units.ev2Ha, d/units.ev2Ha) )
    m.close()

t = 0.0
Hvib.append(hvib)
       
params = {}

decos      = [0,1,2,3]
bz_schemes = [0,1,2]
temps      = [100.0*k for k in xrange(1,11)]

for deco in decos:

    deco_time = 0.0
    # If using mSDM or DISH, set manual decoherence times
    if deco == 2 or deco == 3:

        tau, rates = decoherence_times.decoherence_times_ave(Hvib, [0], nsteps, 0)
        params["decoherence_constants"] = 1
        params["decoherence_times"] = tau

    else:
        tau = MATRIX(2,2)
        tau.set(1,0, 0.0)
        params["decoherence_constants"] = 0

    for bz_scheme in bz_schemes:

        g = open("_res_"+str(deco)+str(bz_scheme)+"_"+str(deco_time)+".txt","w");g.close()

        # For NA-MD Temperature
        for temp in temps:

            # Update params
            params.update({"T":temp, "ntraj":ntrajs, "sh_method":1, "decoherence_method":deco, "dt":dt})
            params.update({"nsteps":nsteps, "Boltz_opt":bz_scheme})
            params.update({"istate":1, "init_times":[0], "outfile":"_tmp_"+str(deco)+str(bz_scheme)+"_"+str(temp)+"_"+str(deco_time)+".txt"})
            params.update({"data_set_paths":[""]})

            # Run Dynamics
            res = step4.run(Hvib, params)

            # Begin Analysis
            t = []
            shE, shP0, shP1 = [], [], []
            seE, seP0, seP1 = [], [], []
            sh0_avg, sh1_avg = 0.0, 0.0
            se0_avg, se1_avg = 0.0, 0.0


            # Need to calculate the Eq. populations for each state:
            # First, compute all of the average exponents. Here, we have only
            # 2-States, so we  only need to compute 2 averages.
            exp_avg = [0.0, 0.0]
            for i in xrange(nsteps):
                for j in xrange(2):
                    Ej = Hvib[0][0].get(j,j).real
                    exp_avg[j] += math.exp( - Ej / (units.kB*temp) )
            exp_avg[0] /= nsteps
            exp_avg[1] /= nsteps

            P0_eq = exp_avg[0] / sum(exp_avg)
            P1_eq = exp_avg[1] / sum(exp_avg)

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

            print "\nPopulation of states at equilibirum for Temp", temp, " = "
            print "P0_eq = ", P0_eq
            print "P1_eq = ", P1_eq
            print "Check: P0_eq + P1_eq = ", P0_eq + P1_eq
            print "\nWe are doing, ", "T = ", temp, "Deco_method = ", deco
            print "Decoherence times for states (0,1) using deco_method", deco, "are "
            print tau.get(1,0) / units.fs2au, "fs"
            print "We are treating frustrated hops using scheme: ", bz_scheme
            print "P0_nbra = ", sh0_avg
            print "P1_nbra = ", sh1_avg
 
            #print "Expected Boltzman populations factor, total pop on state 1 / total pot on stat 0 ", boltz_pop
            sh_ratio = sh1_avg / sh0_avg  #shP1[nsteps-1]/shP0[nsteps-1]
            se_ratio = se1_avg / se0_avg  #seP1[nsteps-1]/seP0[nsteps-1]
            print "actual ratio of the SH populations on the two states, at equilibrium = ", sh_ratio
            print "actual ratio of the SE populations on the two states, at equilibrium = ", se_ratio

            g = open("_res_"+str(deco)+str(bz_scheme)+"_"+str(deco_time)+".txt","a")
            g.write("%s  %s  %8.5f\n" % (temp, sh_ratio, P1_eq/P0_eq))
            g.close()          
            #"""

