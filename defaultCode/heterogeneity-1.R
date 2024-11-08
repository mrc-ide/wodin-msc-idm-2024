##Differential equations

deriv(S_w) <- -betaMW_1c*pcr_1c*S_w*I_m/N_m + recovery_1c*I_w
deriv(S_m) <- -betaWM_1c*pcr_1c*S_m*I_w/N_w + recovery_1c*I_m

deriv(I_w) <- betaMW_1c*pcr_1c*S_w*I_m/N_m - recovery_1c*I_w
deriv(I_m) <- betaWM_1c*pcr_1c*S_m*I_w/N_w - recovery_1c*I_m


##Initial conditions

initial(S_w) <- 99990
initial(S_m) <- 99990

initial(I_w) <- 10
initial(I_m) <- 10


##Other equations

N_w <- S_w+I_w
N_m <- S_m+I_m
N_all <- N_w+N_m



##Parameter values

pcr_1c <-user(2)		#partner change rate
betaMW_1c <- user(0.5)  	#per partner STI transmission probability, men to women
betaWM_1c <- user(0.5)  	#per partner STI transmission probability, women to men
recovery_1c <- user(2)          #recovery rate of infection per person per year (1/mean duration in years)		


##Additional outputs

output(PopSize) <- N_w+N_m
output(prevalence_w) <- I_w/N_w
output(prevalence_m) <- I_m/N_m
output(prevalence_all) <- (I_w+I_m)/N_all
output(newInf_w) <- betaMW_1c*pcr_1c*S_w*I_m/N_m
output(newInf_m) <- betaWM_1c*pcr_1c*S_m*I_w/N_w
output(newInf_all) <- betaMW_1c*pcr_1c*S_w*I_m/N_m + betaWM_1c*pcr_1c*S_m*I_w/N_w
