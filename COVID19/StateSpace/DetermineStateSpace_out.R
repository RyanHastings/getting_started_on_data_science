###############################################################
# DetermineStateSpace_out.R
#
# Organizes output for DetermineStateSpace.R
###############################################################
# Ryan Hastings, 5 May 2020
###############################################################

H=H+G+Q
C=G+Q

for (t in 1:maxt) {

  StateSpace[PhaseOneReduction,Rhosp_vec_i,Rcrit_vec_i,1,t]=round(H[t])
  StateSpace[PhaseOneReduction,Rhosp_vec_i,Rcrit_vec_i,2,t]=round(C[t])
  StateSpace[PhaseOneReduction,Rhosp_vec_i,Rcrit_vec_i,3,t]=round(D[t])
  StateSpace[PhaseOneReduction,Rhosp_vec_i,Rcrit_vec_i,4,t]=round(Dday[t])
  
}