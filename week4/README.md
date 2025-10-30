#2.2
#p-value for maternal age vs dnm frequency: 2e-16 ***
#slope for linear regression 0.37757 - for every year that the mother is older, the frequency of dnms increases by over 30%
#This does roughly match my plot, a best fit line with a slope of 0.4 would be in the middle of most of my points
#the p-value is very small, making this relationship significant
#the probability that this level of association between maternal age and DNM frequency arose by chance is very, very small (essentially zero), indicating a very strong correlation

#2.3
#paternal age vs dnm frequency
#slope for linear regression: 1.35384
#p-value: <2e016 ***
#for every year that the father is older, the frequency of dnms increases by 130%
#this does roughly match my plot - a best fit line with a slope of 1.4 would be in the middle of most of the points
#this p-value is very small, making this relationship significant
#the probablility that this level of association between paternal age and DNM frequency arose by change is very, very small (essentially zero), indicating a very strong correlation

#2.4
#dnm frequency = paternal age * 1.35384 + 10.32632
#for a 50.5 year old father, dnm frequency = 78.695
#(50.5)*1.354 + 10.326

#2.6
# mean difference btw maternal and paternal dnm frequence = -39.23
#p-value < 2.2e-16, making this relationship significant
#the probability that this correlation between maternal and paternal dnm frequency arose by chance is very, very close to zero
#using lm(), coefficient estimate for intercept term = -39.2348
#same as t-test mean difference with same very small p-value
#coefficient estimate for intercept term is the average difference in counts btw maternal and paternal dnms


#3.1 Chose the palmtrees dataset
#3.3 Linear model hypothesis: Do trees with more leaves grow bigger fruit? 
# Yes and this is statistically significant (p-value 1.06e-12)
#slope is very small though (0.05), so this is a very small correlation
#could be argued that this is not a correlation, but I think it might be a small correlation because
#every extra leaf probably has a very, very small effect on tree photosynthesis
#could also be that healthier trees overall have more fruit and more leaves, but would need more data to determine this
