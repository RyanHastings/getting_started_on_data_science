#############################################################
# MODEL_INITIALIZATION.R
#
# Initialize the model arrays for running the model.
#############################################################
# Ryan Hastings, 26 Mar 2020
#############################################################
ncounties<-ncounties+1
#############################################################
# Initial number of cases per county
seed_I<-array(0,dim=c(ncounties,maxt,nage))
In<-seed_I
if (initialization_method==0) {
  for (i in 1:ncounties) {
    seed_I[i,1,1]=1
  }
} else if (initialization_method==2) {
  init_filename<-paste(datadir,initialization_file,sep="")
  init_data<-read_csv(init_filename,col_types=cols(
    FIPS=col_integer(),
    County=col_character(),
    DateFirstConfirmed=col_date(format="%m/%d/%Y"),
    DateFirstDeath=col_date(format="%m/%d/%Y"),
    X5=col_character()
  ))
  null_start_date<-Sys.Date()
  init_data$DateFirstConfirmed[is.na(init_data$DateFirstConfirmed)]<-null_start_date
  init_data<-init_data%>%mutate(DayZero=DateFirstConfirmed-DayZeroOffset)
  day_zero_date=min(init_data$DayZero)
  init_data<-init_data%>%mutate(DayFromDayZero=DayZero-day_zero_date)
  for (i in 1:ncounties-1) {
    t<-init_data$DayFromDayZero[i]+1
    seed_I[i,t,1]<-0.25
  }
  if (statewide_method==0) {
    seed_I[ncounties,1,1]<-1
  }
}
#In<-seed_I
  
#############################################################
# get county populations
#
# This will need to be modified for your state
US.pop.raw<-read_csv(paste(datadir,'/PEP_2018_PEPAGESEX_with_ann.csv',sep=""))
state_name<-paste(",",state_name)
IN.pop.raw<-US.pop.raw%>%filter(grepl(state_name,`GEO.display-label`))
county_names<-IN.pop.raw$`GEO.display-label`
county_names<-append(county_names,state_name)

S<-array(0,dim=c(ncounties,maxt,nage))

if (nage==1) {
  for (i in 1:ncounties-1) {
    S[i,1,1]<-as.numeric(IN.pop.raw$est42010sex0_age999[i])*Pinf
    S[i,2:maxt,1]<-0
  }
  if (statewide_pop==0) {
    S[ncounties,1,1]<-sum(S[1:ncounties-1,1,1])
  } else {
    S[ncounties,1,1]<-statewide_pop
  }
} else if (nage==7) {
  for (i in 1:ncounties-1) {

    S[i,1,1]<-as.numeric(IN.pop.raw$est72018sex0_age0to4[i])+
      as.numeric(IN.pop.raw$est72018sex0_age5to9[i])+
      as.numeric(IN.pop.raw$est72018sex0_age10to14[i])+
      as.numeric(IN.pop.raw$est72010sex0_age15to19[i])



    S[i,1,2]<-as.numeric(IN.pop.raw$est72018sex0_age20to24[i])+
      as.numeric(IN.pop.raw$est72018sex0_age25to29[i])+
      as.numeric(IN.pop.raw$est72018sex0_age30to34[i])+
      as.numeric(IN.pop.raw$est72018sex0_age35to39[i])


    S[i,1,3]<-as.numeric(IN.pop.raw$est72018sex0_age40to44[i])+
      as.numeric(IN.pop.raw$est72018sex0_age45to49[i])


    S[i,1,4]<-as.numeric(IN.pop.raw$est72018sex0_age50to54[i])+
      as.numeric(IN.pop.raw$est72018sex0_age55to59[i])


    S[i,1,5]<-as.numeric(IN.pop.raw$est72018sex0_age60to64[i])+
      as.numeric(IN.pop.raw$est72018sex0_age65to69[i])


    S[i,1,6]<-as.numeric(IN.pop.raw$est72018sex0_age70to74[i])+
      as.numeric(IN.pop.raw$est72018sex0_age75to79[i])


    S[i,1,7]<-as.numeric(IN.pop.raw$est72018sex0_age80to84[i])+
      as.numeric(IN.pop.raw$est72018sex0_age85plus[i])
    
  }
  S[ncounties,1,1]=sum(S[1:ncounties-1,1,1])
  S[ncounties,1,2]=sum(S[1:ncounties-1,1,2])
  S[ncounties,1,3]=sum(S[1:ncounties-1,1,3])
  S[ncounties,1,4]=sum(S[1:ncounties-1,1,4])
  S[ncounties,1,5]=sum(S[1:ncounties-1,1,5])
  S[ncounties,1,6]=sum(S[1:ncounties-1,1,6])
  S[ncounties,1,7]=sum(S[1:ncounties-1,1,7])
  S[ncounties,1,8]=sum(S[1:ncounties-1,1,8])
} else if (nage==8) {
  for (i in 1:ncounties-1) {
      
    S[i,1,1]<-as.numeric(IN.pop.raw$est72018sex0_age0to4[i])+
      as.numeric(IN.pop.raw$est72018sex0_age5to9[i])+
      as.numeric(IN.pop.raw$est72018sex0_age10to14[i])+
      as.numeric(IN.pop.raw$est72010sex0_age15to19[i])
      
      
      
    S[i,1,2]<-as.numeric(IN.pop.raw$est72018sex0_age20to24[i])+
      as.numeric(IN.pop.raw$est72018sex0_age25to29[i])
      
    S[i,1,3]<-as.numeric(IN.pop.raw$est72018sex0_age30to34[i])+
      as.numeric(IN.pop.raw$est72018sex0_age35to39[i])
      
      
    S[i,1,4]<-as.numeric(IN.pop.raw$est72018sex0_age40to44[i])+
      as.numeric(IN.pop.raw$est72018sex0_age45to49[i])
      
      
    S[i,1,5]<-as.numeric(IN.pop.raw$est72018sex0_age50to54[i])+
      as.numeric(IN.pop.raw$est72018sex0_age55to59[i])
      
      
    S[i,1,6]<-as.numeric(IN.pop.raw$est72018sex0_age60to64[i])+
      as.numeric(IN.pop.raw$est72018sex0_age65to69[i])
      
      
    S[i,1,7]<-as.numeric(IN.pop.raw$est72018sex0_age70to74[i])+
      as.numeric(IN.pop.raw$est72018sex0_age75to79[i])
      
      
    S[i,1,8]<-as.numeric(IN.pop.raw$est72018sex0_age80to84[i])+
      as.numeric(IN.pop.raw$est72018sex0_age85plus[i])
  }
  
  S[ncounties,1,1]=sum(S[1:ncounties-1,1,1])
  S[ncounties,1,2]=sum(S[1:ncounties-1,1,2])
  S[ncounties,1,3]=sum(S[1:ncounties-1,1,3])
  S[ncounties,1,4]=sum(S[1:ncounties-1,1,4])
  S[ncounties,1,5]=sum(S[1:ncounties-1,1,5])
  S[ncounties,1,6]=sum(S[1:ncounties-1,1,6])
  S[ncounties,1,7]=sum(S[1:ncounties-1,1,7])
  S[ncounties,1,8]=sum(S[1:ncounties-1,1,8])
}


##########################################################
# Initialize other variables

dSdt<-array(0,dim=c(ncounties,maxt,nage))
    
E<-array(0,dim=c(ncounties,maxt,nage))
dEdt<-array(0,dim=c(ncounties,maxt,nage))
    
dIdt<-array(0,dim=c(ncounties,maxt,nage))
    
H<-array(0,dim=c(ncounties,maxt,nage))
dHdt<-array(0,dim=c(ncounties,maxt,nage))
  
C<-array(0,dim=c(ncounties,maxt,nage))
dCdt<-array(0,dim=c(ncounties,maxt,nage))
  
R<-array(0,dim=c(ncounties,maxt,nage))
dRdt<-array(0,dim=c(ncounties,maxt,nage))
  
Q<-array(0,dim=c(ncounties,maxt,nage))
dQdt<-array(0,dim=c(ncounties,maxt,nage))
  
G<-array(0,dim=c(ncounties,maxt,nage))
dGdt<-array(0,dim=c(ncounties,maxt,nage))
  
D<-array(0,dim=c(ncounties,maxt,nage))
dDdt<-array(0,dim=c(ncounties,maxt,nage))
Dday<-array(0,dim=c(ncounties,maxt,nage))
    
Ecum<-array(0,dim=c(ncounties,maxt,nage))
Icum<-array(0,dim=c(ncounties,maxt,nage))
Hcum<-array(0,dim=c(ncounties,maxt,nage))
Ccum<-array(0,dim=c(ncounties,maxt,nage))
Qcum<-array(0,dim=c(ncounties,maxt,nage))
Gcum<-array(0,dim=c(ncounties,maxt,nage))

dates<-c(seq.Date(day_zero_date,day_zero_date+maxt-1,"days"))

