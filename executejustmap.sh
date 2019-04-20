# #################################
# Run all files - full automation. This file must remain in the local working directory with all relevant files.
# Must have R installed in order to use Rscript! Make sure required R packages are installed.
# R pkgs needed: MASS, robust, ellipse (install all dependencies)
# Run script through GMT-enabled terminal
# Val Finlayson, September 2016
# #################################

echo --EXECUTE.SH--
echo Just the map, none of the Monte Carlo, all of the lazy

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