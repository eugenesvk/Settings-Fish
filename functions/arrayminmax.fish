function arrayminmax -d 'Find Min and Max number in an array and store in global f_ArrayMinMax_Min/f_ArrayMinMax_Max'
	set arrayName $argv  	# This is how to declare / initialize an array
	set max $arrayName[1]	# Use choose first element of array as initial values for min/max; (Defensive programming)
	set min $arrayName[1]	#
	for i in $arrayName  	# Loop through all elements in the array and update Max/Min if found a higher/lower element
	  if test $i -gt $max; set max $i; end
	  if test $i -lt $min; set min $i; end
	end
	# Output results:
	set -g f_ArrayMinMax_Min $min
	set -g f_ArrayMinMax_Max $max
	# echo "Max is: $f_ArrayMinMax_Max"
	# echo "Min is: $f_ArrayMinMax_Min"
end
