# #################################
# Run all files - full automation. This file must remain in the local working directory with all relevant files.
# Must have R installed in order to use Rscript! Make sure required R packages are installed.
# R pkgs needed: MASS, robust, ellipse (install all dependencies)
# Run script through GMT-enabled terminal
# Val Finlayson, September 2016
# #################################

echo --EXECUTE.SH--
echo Monte Carlo simulation n=1000 of uncertainty on KDE-based HEB location estimates

# clear old tuv sim files
echo --Removing old perturbed age files ...
rm tuv1*
rm tuv2*
rm tuv3*
rm tuv4*
rm tuv5*
rm tuv6*
rm tuv7*
rm tuv8*
rm tuv9*
echo --Done.

# Generate Monte Carlo-simulated age data for Rurutu-origin Tuvalus, n=100
echo --Step 1: Calling HEBmontecarlo.R to generate new perturbed age files ...
echo --Uncomment line set.seed to replicate random number generator results
Rscript HEBmontecarlo.R
echo --Done.

# Run GMT/file formatting script
echo --Step 2: Calling mcheb.sh to run age files though GMT backtracker, clean up for R ...
./mcheb.sh
echo --Done.

# Postmortem on results - what does the simulation tell us?
echo --Step 3: Generating KDEs of backtracker output and writing results for GMT ... please be patient ...
#Rscript HEBerrorsimulated.R # Does not determine combined matrix results; faster
Rscript HEBerrorsimulatedwithcomb.R # Determines D12*WK08 and D12*WK08*DC85 results; increases runtime ~67%
echo --Done.

echo --Making map of results ...
# GMT plot ellipses
region='177/180/-11/-6'
psfile=HEBsEllipse.ps
grdfile='tuvalu_final.grd'

echo --Running grdimage ...   
grdimage $grdfile -JM15 -R$region -Cpac2.cpt -X2 -Y2 -K -V -P > $psfile
	
# Plot data, post-processing in Illustrator required
echo --Plotting MCD ellipses ...
psxy HEBs.txt -JM15 -R$region -G0 -Sd0.3 -O -V -K >> $psfile
psxy ellipseD12 -JM15 -R$region -Lp -O -V -K >> $psfile
psxy ellipseWK08 -JM15 -R$region -Lp -O -V -K >> $psfile
psxy ellipseDC85 -JM15 -R$region -Lp -O -V -K >> $psfile
psxy ellipseboth -JM15 -R$region -Lp -O -V -K >> $psfile # comment out if running HEBerrorsimulated.R
psxy ellipseall -JM15 -R$region -Lp -O -V -K >> $psfile # comment out if running HEBerrorsimulated.R

echo --Running psbasemap...
psbasemap -J -R$region -Ba1 -O -V >> $psfile

echo --Done.