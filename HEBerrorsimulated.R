# "/Users/valeriefinlayson/Documents/_ResearchProjects/_Dissertation/_Rurutu/_DataGeneralRepository/_Scripts4Paper/matlab_gmt_scripts/_DoubrovineAPMData/_MonteCarlo"

# Process Monte Carlo output from HEB code

library(MASS)

for(j in 1:1){

	if (j==1) {
	files = Sys.glob("WK08r-*")
	model=c('WK08')
	}
	if (j==2) {
		files = Sys.glob("D12r-*")
		model=c('D12')
	}
	if (j==3) {
		files = Sys.glob("DC85r-*")
		model=c('DC85')
		}

	for(count in 1:1000){
	
		WK08.dat <- read.table(files[count], header = FALSE, sep = "	", na.strings = "NaN")
		
		rursiz=dim(WK08.dat)
	
		for (i in 1:rursiz[1]) {
			if (WK08.dat$V1[i]<0) {
				WK08.dat$V1[i]=(360+WK08.dat$V1[i])
			}
		}
		
		kdeWK08=kde2d(WK08.dat$V1,WK08.dat$V2, n=500, lims=c(150,220,-35,30))
		
		sideWK=dim(kdeWK08$z)
		densmaxWK=max(kdeWK08$z)
		k=1
		for (k in 1:sideWK[1]) {
			test=which.max(kdeWK08$z[k,1:sideWK[2]])
			if (densmaxWK== kdeWK08$z[k,test]) {
				HEBlon=k
				print(paste(model,' HEB here (x address/lon, y address/lat):'))
				print(HEBlon)
				print(kdeWK08$x[HEBlon])
				HEBlat=test
				print(HEBlat)
				print(kdeWK08$y[HEBlat])
				print(j)
				print(count)
				#write(as.character(kdeWK08$x[HEBlon],kdeWK08$y[HEBlat]), ncolumns=2, file = paste("HEBsWK08.txt", sep = ""), append = TRUE)
				cat(kdeWK08$x[HEBlon],"\t", kdeWK08$y[HEBlat], "\n", file=paste("HEBs",model,".txt",sep=''), append=TRUE, sep='')
	
			}
		}
		
	} # end inner nested loop
} # end outer nested loop

# Once all loops are finished, get file data, make plots, get covariance, print ellipses to plot in GMT
HEBwk.dat <- read.table('HEBsWK08.txt', header = FALSE, sep = "	", na.strings = "NaN")
HEBd.dat <- read.table('HEBsD12.txt', header = FALSE, sep = "	", na.strings = "NaN")
HEBdc.dat <- read.table('HEBsDC85.txt', header = FALSE, sep = "	", na.strings = "NaN")

quartz()
plot(HEBwk.dat$V1,HEBwk.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBd.dat$V1,HEBd.dat$V2,pch=21,bg=3,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBdc.dat$V1,HEBdc.dat$V2,pch=21,bg=4,xlim=c(177,180),ylim=c(-11,-6.5))

library(ellipse)
library(robust)

covwk=cov(HEBwk.dat)
covd=cov(HEBd.dat)
covdc=cov(HEBdc.dat)

covwk=cov(HEBwk.dat)
covd=cov(HEBd.dat)
covdc=cov(HEBdc.dat)

covMwk=covMcd(HEBwk.dat)
covMd=covMcd(HEBd.dat)
covMdc=covMcd(HEBdc.dat)

quartz()
plot(ellipse(covwk,centre=c(mean(HEBwk.dat$V1),mean(HEBwk.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('WK08'))
par(new=TRUE)
plot(ellipse(covMwk$cov,centre=c(covMwk$center)),type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBwk.dat$V1,HEBwk.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBwk.dat$V1),mean(HEBwk.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

#export ellipse for plotting in GMT using psxy, closed polygon form
ellwk = ellipse(covMwk$cov,centre=c(covMwk$center))
sizeell=dim(ellwk)
write(paste(ellwk[1:sizeell[1],1],ellwk[1:sizeell[1],2]), file = "ellipseWK08", ncolumns=1, append = FALSE)

quartz()
plot(ellipse(covd,centre=c(mean(HEBd.dat$V1),mean(HEBd.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('D12'))
par(new=TRUE)
plot(ellipse(covMd$cov,centre=c(covMd$center)),type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBd.dat$V1,HEBd.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBd.dat$V1),mean(HEBd.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

#export ellipse for plotting in GMT using psxy, closed polygon form
elld = ellipse(covMd$cov,centre=c(covMd$center))
sizeell=dim(elld)
write(paste(elld[1:sizeell[1],1],elld[1:sizeell[1],2]), file = "ellipseD12", ncolumns=1, append = FALSE)

quartz()
plot(ellipse(covdc,centre=c(mean(HEBdc.dat$V1),mean(HEBdc.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('DC85'))
par(new=TRUE)
plot(ellipse(covMdc$cov,centre=c(covMdc$center)), type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBdc.dat$V1,HEBdc.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBdc.dat$V1),mean(HEBdc.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

#export ellipse for plotting in GMT using psxy, closed polygon form
elldc = ellipse(covMdc$cov,centre=c(covMdc$center))
sizeell=dim(elldc)
write(paste(elldc[1:sizeell[1],1],elldc[1:sizeell[1],2]), file = "ellipseDC85", ncolumns=1, append = FALSE)

