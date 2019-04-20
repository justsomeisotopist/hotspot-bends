# "/Users/valeriefinlayson/Documents/_ResearchProjects/_Dissertation/_Rurutu/_DataGeneralRepository/_Scripts4Paper/matlab_gmt_scripts/_DoubrovineAPMData/_MonteCarlo"

# Process Monte Carlo output from HEB code

library(MASS)
library(ellipse)
library(robust)




		WK08.dat <- read.table('WK08origr', header = FALSE, sep = "	", na.strings = "NaN")
		
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
				print(paste('WK08 HEB here (x address/lon, y address/lat):'))
				print(HEBlon)
				print(kdeWK08$x[HEBlon])
				HEBlat=test
				print(HEBlat)
				print(kdeWK08$y[HEBlat])
				#print(j)
				#print(count)
				#write(as.character(kdeWK08$x[HEBlon],kdeWK08$y[HEBlat]), ncolumns=2, file = paste("HEBsWK08.txt", sep = ""), append = TRUE)
	
			}

		}
			quartz()
			plot(kdeWK08$x[HEBlon],kdeWK08$y[HEBlat], xlim=c(150,220),ylim=c(-35,30),pch=24)
			par(new=TRUE)
			contour(kdeWK08,drawlabels=FALSE)
			
			

########
# D12

		D12.dat <- read.table('D12origr', header = FALSE, sep = "	", na.strings = "NaN")
		
		rursiz=dim(D12.dat)
	
		for (i in 1:rursiz[1]) {
			if (D12.dat$V1[i]<0) {
				D12.dat$V1[i]=(360+D12.dat$V1[i])
			}
		}
		
		kdeD12=kde2d(D12.dat$V1,D12.dat$V2, n=500, lims=c(150,220,-35,30))
		
		sideD=dim(kdeD12$z)
		densmaxD=max(kdeD12$z)
		k=1
		for (k in 1:sideD[1]) {
			test=which.max(kdeD12$z[k,1:sideD[2]])
			if (densmaxD== kdeD12$z[k,test]) {
				HEBlon=k
				print(paste('D12 HEB here (x address/lon, y address/lat):'))
				print(HEBlon)
				print(kdeD12$x[HEBlon])
				HEBlat=test
				print(HEBlat)
				print(kdeD12$y[HEBlat])
				#print(j)
				#print(count)
				#write(as.character(kdeWK08$x[HEBlon],kdeWK08$y[HEBlat]), ncolumns=2, file = paste("HEBsWK08.txt", sep = ""), append = TRUE)
	
			}
		}
			quartz()
			plot(kdeD12$x[HEBlon],kdeD12$y[HEBlat], xlim=c(150,220),ylim=c(-35,30),pch=24)
			par(new=TRUE)
			contour(kdeD12, drawlabels=FALSE, plot.title=title("Doubrovine et al., 2012"),xlim=c(150,220),ylim=c(-35,30))
			

########
# DC85
	
		DC85.dat <- read.table('DC85origr', header = FALSE, sep = "	", na.strings = "NaN")
		
		rursiz=dim(DC85.dat)
	
		for (i in 1:rursiz[1]) {
			if (DC85.dat$V1[i]<0) {
				DC85.dat$V1[i]=(360+ DC85.dat$V1[i])
			}
		}
		
		kdeDC85 =kde2d(DC85.dat$V1, DC85.dat$V2, n=500, lims=c(150,220,-35,30))
		
		sideDC=dim(kdeDC85$z)
		densmaxDC=max(kdeDC85$z)
		k=1
		for (k in 1:sideDC[1]) {
			test=which.max(kdeDC85$z[k,1:sideDC[2]])
			if (densmaxDC== kdeDC85$z[k,test]) {
				HEBlon=k
				print(paste('DC85 HEB here (x address/lon, y address/lat):'))
				print(HEBlon)
				print(kdeDC85$x[HEBlon])
				HEBlat=test
				print(HEBlat)
				print(kdeDC85$y[HEBlat])
				#print(j)
				#print(count)
				#write(as.character(kdeWK08$x[HEBlon],kdeWK08$y[HEBlat]), ncolumns=2, file = paste("HEBsWK08.txt", sep = ""), append = TRUE)
	
			}

		}
			quartz()
			plot(kdeDC85$x[HEBlon],kdeDC85$y[HEBlat], xlim=c(150,220),ylim=c(-35,30),pch=24)
			par(new=TRUE)
			contour(kdeDC85,drawlabels=FALSE)

			
			
		
		# Combine D12 and WK08:
		# Combine matrices to find where both think the HEB should be:
		kdeboth = kdeD12$z*kdeWK08$z
		kdeboth2 = kdeD12
		kdeboth2$z = kdeboth # associates combined KDE with the proper lat/lon coordinates
		side=dim(kdeboth2$z)
		densmax=max(kdeboth2$z)
		j=1
		for (j in 1:side[1]) {
			test=which.max(kdeboth2$z[j,1:side[2]])
			if (densmax==kdeboth2$z[j,test]) {
				HEBlon=j
				print('Combined model HEB here (x address/lon, y address/lat):')
				print(HEBlon)
				print(kdeboth2$x[HEBlon])
				HEBlat=test
				print(HEBlat)
				print(kdeboth2$y[HEBlat])
			}
		}
		quartz()
		par(new=TRUE)
		plot(kdeboth2$x[HEBlon],kdeboth2$y[HEBlat], xlim=c(150,220),ylim=c(-35,30),pch=24)
		par(new=TRUE)
		contour(kdeboth2,drawlabels=FALSE,xlim=c(150,220),ylim=c(-35,30))
		
		# For all three combined:
		kdeall = kdeboth*kdeDC85$z
		kdeall2 = kdeD12 # prime
		kdeall2$z = kdeall
		sideDC=dim(kdeall2$z)
		densmaxDC=max(kdeall2$z)
		n=1
		for (n in 1:sideDC[1]) {
			test=which.max(kdeall2$z[n,1:sideDC[2]])
			if (densmaxDC== kdeall2$z[n,test]) {
				HEBlon=n
				print('All three combined HEB here (x address/lon, y address/lat):')
				print(HEBlon)
				print(kdeall2$x[HEBlon])
				HEBlat=test
				print(HEBlat)
				print(kdeall2$y[HEBlat])
			}

		}
		quartz()
		plot(kdeall2$x[HEBlon],kdeall2$y[HEBlat], xlim=c(150,220),ylim=c(-35,30),pch=24)
		par(new=TRUE)
		contour(kdeall2,drawlabels=FALSE,xlim=c(150,220),ylim=c(-35,30))




# Once all loops are finished, get file data, make plots, get covariance, print ellipses to plot in GMT
HEBwk.dat <- read.table('HEBsWK08.txt', header = FALSE, sep = "	", na.strings = "NaN")
HEBd.dat <- read.table('HEBsD12.txt', header = FALSE, sep = "	", na.strings = "NaN")
HEBdc.dat <- read.table('HEBsDC85.txt', header = FALSE, sep = "	", na.strings = "NaN")
HEBboth.dat <- read.table('HEBsboth.txt', header = FALSE, sep = "	", na.strings = "NaN")
HEBall.dat <- read.table('HEBsall.txt', header = FALSE, sep = "	", na.strings = "NaN")

quartz()
plot(HEBwk.dat$V1,HEBwk.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBd.dat$V1,HEBd.dat$V2,pch=21,bg=3,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBdc.dat$V1,HEBdc.dat$V2,pch=21,bg=4,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBboth.dat$V1,HEBboth.dat$V2,pch=21,bg=5,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBall.dat$V1,HEBall.dat$V2,pch=21,bg=6,xlim=c(177,180),ylim=c(-11,-6.5))

covwk=cov(HEBwk.dat)
covd=cov(HEBd.dat)
covdc=cov(HEBdc.dat)
covboth=cov(HEBboth.dat)
covall=cov(HEBall.dat)

covMwk=covMcd(HEBwk.dat)
covMd=covMcd(HEBd.dat)
covMdc=covMcd(HEBdc.dat)
covMboth=covMcd(HEBboth.dat)
covMall=covMcd(HEBall.dat)

quartz()
plot(ellipse(covwk,centre=c(mean(HEBwk.dat$V1),mean(HEBwk.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('WK08'))
par(new=TRUE)
plot(ellipse(covMwk$cov,centre=c(covMwk$center)),type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBwk.dat$V1,HEBwk.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBwk.dat$V1),mean(HEBwk.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

quartz()
plot(ellipse(covd,centre=c(mean(HEBd.dat$V1),mean(HEBd.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('D12'))
par(new=TRUE)
plot(ellipse(covMd$cov,centre=c(covMd$center)),type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBd.dat$V1,HEBd.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBd.dat$V1),mean(HEBd.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

quartz()
plot(ellipse(covdc,centre=c(mean(HEBdc.dat$V1),mean(HEBdc.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('DC85'))
par(new=TRUE)
plot(ellipse(covMdc$cov,centre=c(covMdc$center)), type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBdc.dat$V1,HEBdc.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBdc.dat$V1),mean(HEBdc.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

quartz()
plot(ellipse(covboth,centre=c(mean(HEBboth.dat$V1),mean(HEBboth.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('both'))
par(new=TRUE)
plot(ellipse(covMboth$cov,centre=c(covMboth$center)), type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBboth.dat$V1,HEBboth.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBboth.dat$V1),mean(HEBboth.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

quartz()
plot(ellipse(covall,centre=c(mean(HEBall.dat$V1),mean(HEBall.dat$V2))),type='l',xlim=c(177,180),ylim=c(-11,-6.5),main=c('all'))
par(new=TRUE)
plot(ellipse(covMall$cov,centre=c(covMall$center)), type='l',col=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(HEBall.dat$V1,HEBall.dat$V2,pch=21,bg=2,xlim=c(177,180),ylim=c(-11,-6.5))
par(new=TRUE)
plot(mean(HEBall.dat$V1),mean(HEBall.dat$V2),xlim=c(177,180),ylim=c(-11,-6.5))

