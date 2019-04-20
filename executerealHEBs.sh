# #################################
# Run all files - full automation. This file must remain in the local working directory with all relevant files.
# Must have R installed in order to use Rscript! Make sure required R packages are installed.
# R pkgs needed: MASS, robust, ellipse (install all dependencies)
# Run script through GMT-enabled terminal
# Val Finlayson, September 2016
# #################################

echo --EXECUTEREALHEBS.SH--
echo determine actual KDE-based HEB location estimates

# Run GMT/file formatting script
echo --Step 1: Run age file though GMT backtracker, clean up for R ...
	# forward in time to 0 Ma
	backtracker tuvalu_updatedoct16.txt -Db -ED12WK08.txt -Lb25 -V > D12orig
	backtracker tuvalu_updatedoct16.txt -Db -EWK08.txt -Lb25 -V > WK08orig
	backtracker tuvalu_updatedoct16.txt -Db -EDC85.txt -Lb25 -V > DC85orig

	# Next, extract the 0 Ma locations, dump into a file, and project backward
	sed -i '' '/> Hotspot/d' D12orig # Remove track headers
	awk '($3==0) {print $1"\t"$2"\t"$3}' D12orig > D12origb # Find 0 Ma positions and print to new file
	sed -i '' '/> Hotspot/d' WK08orig
	awk '($3==0) {print $1"\t"$2"\t"$3}' WK08orig > WK08origb
	sed -i '' '/> Hotspot/d' DC85orig
	awk '($3==0) {print $1"\t"$2"\t"$3}' DC85orig > DC85origb


	# Forward model tracks from 0 Ma files
	backtracker D12origb -Df -ED12WK08.txt -Lb25 -V -A0/120 > D12origr
	backtracker WK08origb -Df -EWK08.txt -Lb25 -V -A0/120 > WK08origr
	backtracker DC85origb -Df -EDC85.txt -Lb25 -V -A0/120 > DC85origr
	
	# Remove headers again for the next batch processing step in R
	sed -i '' '/> Hotspot/d' D12origr
	sed -i '' '/> Hotspot/d' WK08origr
	sed -i '' '/> Hotspot/d' DC85origr
	


echo --Done.

# Postmortem on results - what does the simulation tell us?
echo --Step 2: Generating KDEs of backtracker output and writing results for GMT ... please be patient ...
#Rscript HEBerrorsimulated.R # Does not determine combined matrix results; faster
#Rscript HEBerrorsimulatedwithcomb.R # Determines D12*WK08 and D12*WK08*DC85 results; increases runtime ~67%
Rscript HEBreal.R
echo --Done.



echo --Done.