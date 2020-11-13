############################################################
#### MODEL.MASTER
### Master code for running the SEIHCRD model for Indiana (or
### any other state with appropriate modification). This is based
### on an epidemiological SEIR model, but three populations are
### added:  Hospitalized, Critically hospitalized, and Deceased.
### More info can be found in the accompanying documentation.
############################################################
## Ryan Hastings, 26 March 2020
############################################################
rm(list=ls()) # clear out variables

# Load libraries
library(tidyverse)
library(haven)
library(readxl)

###################### configuration variables ########################

#--------------- basic variables --------------------#
day_zero_date<-as.Date('2020-01-20') # date of Day Zero

R0<-3.0                   # base transmission rate
intervention_time<-65     # day at which to start NPI
intervention_R_rdxn<-0.7  # percentage of reduction in 
                          # transmission rate after NPI
nage<-1                   # number of age groups -- this
                          # will be determined from a census
                          # file
lift_time<-166            # time in days from start of 
                          # simulation to discontinue NPI
postlift_rdxn<-0.0        # reduction in transmission after
                          # NPI is discontinued
maxt<-350                 # maximum number of days to simulate

# first case initialization method
initialization_method<-0 # 0 seed each county with one case at day zero
                         # 1 seed each county at a different date
                         # 2 seed each county at a different date, reading in from file;
                         #   if no cases in county, set day zero to a month ago
initialization_file<-"CountyFirstCase.csv" # for method 2

# directories for use
datadir<-("data")
outdir<- ("out")

# simulate statewide or countywide
statewide_method<-1    # 0: simulate statewide; 1: sum up counties
statewide_pop<-6.692e6 # set to zero to get from census file; only valid for nage=1
ncounties<-92          # number of counties
state_name<-"Indiana"

########## epidemiological variables
Tinc<-5 # incubation time (days)
Tinf<-3 # time of infection before either hospitalization or recovery
Thosp<-8.6 # time in hospitalization until recovery
Tdeath<-10.4 # time in hospital until death
Pinf<-1.0 # max proportion of population to get infected

#--------- Rdeath and Rhosp
Rdeath<-c(seq(0,nage))
Rhosp<-c(seq(0,nage))
Rdeath[1]<-0.002 # Death rate per infected for age groups...10-19 OR if nage==1 (no age groups) this is Rdeath
Rdeath[2]<-0.00031#0.002  # 20 to 39
Rdeath[3]<-0.00084#0.004  # 40 to 49
Rdeath[4]<-0.00160#0.013  # 50 to 59
Rdeath[5]<-0.0060#0.036  # 60 to 69
Rdeath[6]<-0.0190#0.080  # 70 to 79
Rdeath[7]<-0.0430#0.148  # 80 plus
Rdeath[8]<-0.0780
Rhosp[1]<-0.001 # Hospitalization rate per infected for age groups
Rhosp[2]<-0.100
Rhosp[3]<-0.100
Rhosp[4]<-0.100
Rhosp[5]<-0.100
Rhosp[6]<-0.223
Rhosp[7]<-0.223
Rhosp[8]<-0.223
Rcrit=0.001 # proportion to be critically hospitalized

output<-1 # produce output? 0=no, 1=yes.  Output produces is a csv with all of
# the values as columns and a file containing all of the parameter settings
param_notes<-"No county-county transmission, all counties seeded with one case."

###################### set up base string for constructing output file names #################

output_base<-paste(outdir,"/Scenario_R",format(R0,nsmall=1),
                   "_",100*intervention_R_rdxn,
                   "rdxn_lift",lift_time,
                   '_postlift',postlift_rdxn*100,sep="")
model_outfile<-paste(output_base,".csv",sep="") # model data output filenames
param_outfile<-paste(output_base,"_param.txt",sep="") # parameter output filename
print(output_base)

####################### run the model ############################

# run code to initialize model
source("model_initialization.R")

# run model core
source("model_dynamic_core.R")

# output results
source("model_out.R")