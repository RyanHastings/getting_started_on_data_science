######################################################################
# DetermineStateSpace.R
#
# Originally creates a state space over R0, intervention reduction percentage,
# hospitalization rate, and critical rate, for statewide simulation.
# The state space is subsequently used in curve fitting (Fit3curves.R)
######################################################################
# Ryan Hastings, 8 Apr 2020
######################################################################
# Modified to create state space over field of two different intervention
# reductions for Phase Two of Indiana NPIs.
######################################################################
rm(list=ls()) # clear out variables

# this would be just library(tidyverse) but for some reason that
# doesn't work on my work machine
library(tidyverse)
library(haven)
library(readxl)

#######################################################################
##################### CONFIGURATION VARIABLES #########################
maxt=300 # maximum time in days
#R0_vec<-c(seq(2.5,3.5,0.05)) # field of R0 over which to simulate
nvars<-4# number of variables for output (you probably don't want to change this unless you want a huge coding headache)
Npop<-6.692e6 # population of state
R0<-3.0

DayZeroDate<-as.Date("2020-01-20")
PhaseOneDate<-as.Date("2020-03-25")
PhaseOneDay<-as.numeric(PhaseOneDate-DayZeroDate)
PhaseOneReduction_vec<-c(seq(0.0,0.7,0.05)) # field of NPI reduction rate over which to simulate

Rdeath<-0.0066 # IFR (infection fatality rate)
RhospPhaseZero<-0.03 # hospitalization rate per infection before Phase One
RcritPhaseZero<-0.01 # critical hospitalization rate per infection before Phase One
Rhosp_vec<-seq(0.025,0.09,0.005)#0.06 # hospitalization rate
Rcrit_vec<-seq(0.01,0.04,0.001)#0.024 # critical rate

# disease timing
Tinc<-5 # incubation time (days)
Tinf<-3 # time of infection before either hospitalization or recovery
Thosp<-8.6 # time in hospitalization until recovery
Tdeath<-10.4 # time in hospital until death
Tcrit<-7.9 # time in ICU until recovery
Pinf<-1.0 # max proportion of population to get infected

outdir<-"StateSpace/" # directory for output
output<-1 # produce output? 0=no, 1=yes.  Output produces is a csv with all of
outfile<-'StateSpace.RData' # output filename

#######################################################################
########################## RUN THE MODEL ##############################
times<-c(seq(0,maxt))

# set up state space
StateSpace<-array(0.0,dim=c(length(PhaseOneReduction_vec),
                            length(Rhosp_vec),
                            length(Rcrit_vec),
                            nvars,maxt))

for (intervention_R_rdxn_i in 1:length(PhaseOneReduction_vec)) {
  for (Rhosp_vec_i in 1:length(Rhosp_vec)) {
    for (Rcrit_vec_i in 1:length(Rcrit_vec)) {            
            
      PhaseOneReduction<-PhaseOneReduction_vec[intervention_R_rdxn_i]
      RhospPhaseOne<-Rhosp_vec[Rhosp_vec_i]
      RcritPhaseOne<-Rcrit_vec[Rcrit_vec_i]
    
      print(paste("lift1=",PhaseOneReduction,"Rcrit=",RcritPhaseOne,"Rhosp=",RhospPhaseOne))
      source("DetermineStateSpace_initalization.R")
      source("DetermineStateSpace_dynamics.R")
      source("DetermineStateSpace_out.R")
      
    }
  }
}

# save as Rdata file
save(StateSpace,file=paste(outdir,outfile,sep=""))