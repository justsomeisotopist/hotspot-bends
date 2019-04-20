# "/Users/valeriefinlayson/Documents/_ResearchProjects/_Dissertation/_Rurutu/_DataGeneralRepository/_Scripts4Paper/matlab_gmt_scripts/_DoubrovineAPMData/_MonteCarlo"

# Sequence: 1) This file 2) Shell script GMT interface 3) HEBerrorsimulated.R

# Generate a set of random, normally distributed age perturbations to Tuvalu dataset to feed into GMT backtracker code. Then that output goes back into R to determine error on optimal HEB location found with real data

# First show histogram of 1000 randomly sampled values around a normal distribution.  It goes out to 2SD where SD = 1 (right?), so I want a normal distribution across a range of 7, assuming seamount ages sample the mean age of the seamount (we know bot always the case, but keep the simulation simple). Therefore,
quartz()
hist(3.5*rnorm(1000)/2)
# This is what we want. Perturb ages with it. 

tuvlocage.dat <- read.table("tuvalu_updatedoct16.txt", header = FALSE, sep = "	", na.strings = "NA")

mcage.dat = tuvlocage.dat

tuvdim=dim(tuvlocage.dat)

# Set up loops to generate Monte Carlo-perturbed ages to feed into HEB locator. Start with 10 for dev, move up to 100 for tests, maybe 1000 final?
# set.seed(1) # for testing

for (k in 1:1000) { # how many simulations we're gonna run
	for (n in 1:tuvdim[1]) {
	
		mcage.dat[n,3] = tuvlocage.dat[n,3] + (3.5*rnorm(1)/2)
		write(as.character(mcage.dat[n,1:tuvdim[2]]), ncolumns=4, file = paste("tuv", k, sep = ""), append = TRUE)
	}
	k
	
}
print(k)