##Differential equations

deriv(S_w_l) <- -FOI_w_l*S_w_l + recovery_2c*I_w_l
deriv(S_w_h) <- -FOI_w_h*S_w_h + recovery_2c*I_w_h

deriv(S_m_l) <- -FOI_m_l*S_m_l + recovery_2c*I_m_l
deriv(S_m_h) <- -FOI_m_h*S_m_h + recovery_2c*I_m_h

deriv(I_w_l) <- FOI_w_l*S_w_l - recovery_2c*I_w_l
deriv(I_w_h) <- FOI_w_h*S_w_h - recovery_2c*I_w_h

deriv(I_m_l) <- FOI_m_l*S_m_l - recovery_2c*I_m_l
deriv(I_m_h) <- FOI_m_h*S_m_h - recovery_2c*I_m_h


##Initial conditions

initial(S_w_l) <- 100000*(1-fracHighRisk)*0.999
initial(S_w_h) <- 100000*fracHighRisk*0.999

initial(I_w_l) <- 100000*(1-fracHighRisk)*0.001
initial(I_w_h) <- 100000*fracHighRisk*0.001


initial(S_m_l) <- 100000*(1-fracHighRisk)*0.999
initial(S_m_h) <- 100000*fracHighRisk*0.999

initial(I_m_l) <- 100000*(1-fracHighRisk)*0.001
initial(I_m_h) <- 100000*fracHighRisk*0.001


##Other equations

I_w <- I_w_l+I_w_h
I_m <- I_m_l+I_m_h
N_w <- S_w_l+I_w_l+S_w_h+I_w_h
N_m <- S_m_l+I_m_l+S_m_h+I_m_h
N_all <- N_w+N_m

pcr_2c_l=pcr_2c/(RatioHL*fracHighRisk+(1-fracHighRisk))
pcr_2c_h=pcr_2c_l*RatioHL

mix_random_ll=pcr_2c_l*(1-fracHighRisk)/pcr_2c
mix_random_lh=pcr_2c_h*fracHighRisk/pcr_2c
mix_random_hl=pcr_2c_l*(1-fracHighRisk)/pcr_2c
mix_random_hh=pcr_2c_h*fracHighRisk/pcr_2c

mix_assort_ll=1
mix_assort_lh=0
mix_assort_hl=0
mix_assort_hh=1

mix_final_ll=Epsilon*mix_random_ll+(1-Epsilon)*mix_assort_ll
mix_final_lh=Epsilon*mix_random_lh+(1-Epsilon)*mix_assort_lh
mix_final_hl=Epsilon*mix_random_hl+(1-Epsilon)*mix_assort_hl
mix_final_hh=Epsilon*mix_random_hh+(1-Epsilon)*mix_assort_hh


FOI_w_l=betaMW_2c*pcr_2c_l*(mix_final_ll*(I_m_l/(S_m_l+I_m_l))+(mix_final_lh*(I_m_h/(S_m_h+I_m_h))))
FOI_w_h=betaMW_2c*pcr_2c_h*(mix_final_hl*(I_m_l/(S_m_l+I_m_l))+(mix_final_hh*(I_m_h/(S_m_h+I_m_h))))

FOI_m_l=betaWM_2c*pcr_2c_l*(mix_final_ll*(I_w_l/(S_w_l+I_w_l))+(mix_final_lh*(I_w_h/(S_w_h+I_w_h))))
FOI_m_h=betaWM_2c*pcr_2c_h*(mix_final_hl*(I_w_l/(S_w_l+I_w_l))+(mix_final_hh*(I_w_h/(S_w_h+I_w_h))))


##Parameter values

fracHighRisk <-user(0.2)		# Fraction of high risk among all women and all men
RatioHL <-user(25)		# Ratio of partner change rate in the HR group over in the LR group
pcr_2c <-user(2)		# Partner change rate
Epsilon <-user(1)		# Risk assortativity parameter. WARNING: here, Epsilon = 0 means "assortative", Epsilon = 1 means "random"/"proportionate"

betaMW_2c <- user(0.5)  	# Per partner STI transmission probability, men to women
betaWM_2c <- user(0.5)  	# Per partner STI transmission probability, women to men
#recovery_2c <- user(2)     # Annual recovery rate of infection per person per year (1/mean duration in years)		
DurInf_2c <- user(0.5)     # Mean duration of infectiousness in years (1/recovery rate)		
recovery_2c<-1/DurInf_2c

##Additional outputs

output(PopSize) <- N_w+N_m
output(prevalence_w) <- I_w/N_w
output(prevalence_m) <- I_m/N_m
output(prevalence_w_l) <- I_w_l/(I_w_l+S_w_l)
output(prevalence_m_l) <- I_m_l/(I_m_l+S_m_l)
output(prevalence_w_h) <- I_w_h/(I_w_h+S_w_h)
output(prevalence_m_h) <- I_m_h/(I_m_h+S_m_h)
output(prevalence_all) <- (I_w+I_m)/N_all
output(cLow) <- pcr_2c/(RatioHL*fracHighRisk+(1-fracHighRisk))
output(cHigh) <- pcr_2c_l*RatioHL
