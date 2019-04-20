# hotspot-bends
Uses GMT/UNIX to estimate bend locations in volcanic hotspot tracks

V. A. Finlayson (fm. University of Hawaii at Manoa, now at University of Maryland)

OVERVIEW
This code was developed as an ad-hoc method to pinpoint bends and other geometric features in hotspot tracks in the Pacific Ocean basin where overlap of other hotspot tracks and other volcanic/tectonic features may make visual identification difficult. Morphological characteristics, geometry, locations, and ages of bends and other features in hotspot tracks place important constraints on hotspot-based absolute plate motion models. This information is also useful when evaluating inter-hotspot motion vs. plate motion changes and plume dynamics. The main purpose of this code was to locate a bend in the Rurutu Hotspot Track equivalent to the ~50 Ma bend in the Hawaiian-Emperor Hotspot Track, from which bend ages and morphological characteristics can be compared.

This code is designed to minimize bias from input data (by avoiding looking for any specific age range or location) or human interpretation. Main sources of bias come from the plate motion model Euler poles used to generate density fields from which bend locations can be determined; also the data going in. Therefore, we use 3 different models determined via fundamentally different methods, and which never relied on the part of the Rurutu track we were testing. Goodness of fit for the models vary; please see the main article and supplemental discussion for the article cited at the bottom of this document for more information regarding existing absolute plate motion models and their sources. Still have questions or need access to the paper? Want to discuss? Please get in touch!

IMPLEMENTATION
The script is executed in UNIX. It passes calls to both GMT (http://gmt.soest.hawaii.edu/) and R (https://cran.r-project.org/). The current version of this code requires the MASS, robust, and ellipse libraries to already be installed. Unix, sed, and awk handle script calls and file formatting as necessary, as well as the Monte Carlo analysis for error estimates. GMT calculates plate motion reconstructions for each input point. R does most of the heavy lifting: it calculates the 2D density fields, finds local maxima, estimates ellipses, and calculates results.

There are two ways to run this: 1) Single Solution and 2) Error Estimate.

Single Solution takes an input file with information on seamounts of interest (lon, lat, age in Ma) and produces a single density map and finite location solution (the highest-density point in the density estimate, which is *usually* the ~50 Ma bend). This usually only takes a few seconds to run; depends on size of initial input file and how much data goes into the 2D KDE calculation.

Error Ellipse provides a best estimate of error via Monte Carlo analysis, because there's no good way to directly estimate the error ellipse (i.e. uncertainty) on the Single Solution location. Using a Gaussian random number generator, it simulates 1000 age datasets from the original input, jittered by +/- 3.5 Ma to simulate the estimated average volcanically active lifetime of an oceanic seamount. It then does the entire calculation to determine bend location for all datasets, producing a field from which a 95% confidence ellipse is determined. This mode take considerably longer to run - several hours is normal.

CITATION
If using or modifying this code, please include the following citation:
Finlayson, V.A., Konter, J.G., Konrad, K., Koppers, A.A.P., Jackson, M.G. and Rooney, T.O., 2018. Sr–Pb–Nd–Hf isotopes and 40Ar/39Ar ages reveal a Hawaii–Emperor-style bend in the Rurutu hotspot. Earth and Planetary Science Letters, 500, pp.168-179.
