# Backtrack Tuvalu points; done with data perturbed along a normal distribution to estimate HEB location uncertainty

# Plot flowlines on map
# region='160/210/-30/15'
region2='130/290/0/60'
region='150/230/-35/30'

# Following needs to be looped

num=1
while [ $num -le 1000 ]
do

	# forward in time to 0 Ma
	backtracker tuv$num -Db -ED12WK08.txt -Lb25 -V > D12-$num
	backtracker tuv$num -Db -EWK08.txt -Lb25 -V > WK08-$num
	backtracker tuv$num -Db -EDC85.txt -Lb25 -V > DC85-$num

	# Next, extract the 0 Ma locations, dump into a file, and project backward
	sed -i '' '/> Hotspot/d' D12-$num # Remove track headers
	awk '($3==0) {print $1"\t"$2"\t"$3}' D12-$num > D12b-$num # Find 0 Ma positions and print to new file
	sed -i '' '/> Hotspot/d' WK08-$num
	awk '($3==0) {print $1"\t"$2"\t"$3}' WK08-$num > WK08b-$num
	sed -i '' '/> Hotspot/d' DC85-$num
	awk '($3==0) {print $1"\t"$2"\t"$3}' DC85-$num > DC85b-$num


	# Forward model tracks from 0 Ma files
	backtracker D12b-$num -Df -ED12WK08.txt -Lb25 -V -A0/120 > D12r-$num
	backtracker WK08b-$num -Df -EWK08.txt -Lb25 -V -A0/120 > WK08r-$num
	backtracker DC85b-$num -Df -EDC85.txt -Lb25 -V -A0/120 > DC85r-$num
	
	# Remove headers again for the next batch processing step in R
	sed -i '' '/> Hotspot/d' D12r-$num
	sed -i '' '/> Hotspot/d' WK08r-$num
	sed -i '' '/> Hotspot/d' DC85r-$num
	
	num=`expr $num + 1`

done




