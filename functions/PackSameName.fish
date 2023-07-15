function PackSameName -d "Pack files with the same name, but different extensions, in one zip archive"                #`-d` add description
	set -l DebugVar 0
	set -l DebugDup 0
	set -l DebugZip 0
	set -l ZipLogName "_PackSameName.log"
	set -g filesNoExt

	read_confirm "Do you want to log ZIP command output to $ZipLogName?"; set -l ZipLog $status
	if test $ZipLog -eq 0 -a -e "./$ZipLogName"
		if read_confirm "$ZipLogName already exists in this folder, overwrite(Y) or append(n)?"; rm -v "./$ZipLogName"; end
	end

	set filesNoExt (find . -maxdepth 1 -type f -execdir bash -c 'printf "%s\n" "${@%.*}"' _ '{}' + | sort -u)  # More efficient vs (-exec basename "{}" \;) as it invokes command on all files at once
	arrayminmax (string length $filesNoExt)	 # Store the length of the longest/shortest filename in f_ArrayMinMax_Max/Min

	for i in (seq (count $filesNoExt))
		set -l nm $filesNoExt[$i]              	 # Local var with file name without extension
		set archivelist_ref[$i] "archivelist$i"	 # Reference list for dynamic variables archivelist#
		set archlist (find . -maxdepth 1 -type f -name "$nm*" -execdir bash -c 'printf "%s\n" "${@}"' _ '{}' + | grep -P "(^$nm(?=\.[a-z0-9 ]*\$))|(^$nm(?=\$))")  # List all files that match the file name
		#$@	Expands to the positional parameters, starting from one. When the expansion occurs within double quotes, each parameter expands to a separate word.
		for j in (seq (count $archlist))
			string match -r '\.'              	"$archlist[$j]"	1>/dev/null; set -l statusdot $status 	# there is a dot in the filename (so it's either name.ext or name1.name2.ext)
			string match -r "^$archlist[$j]\$"	$filesNoExt    	1>/dev/null; set -l statusname $status	# filename with the dot matches filename list (so it's only name1.name2.ext)
			string match -r "^$archlist[$j]\$"	$archlist[1]   	1>/dev/null; set -l statusself $status	# filename does not match the first element (so it belongs to this sequence and should not be excluded)
			if test $statusdot -eq 0 -a $statusname -eq 0 -a $statusself -ne 0
				# set archlist[$j] ""
			else
				set $archivelist_ref[$i] $$archivelist_ref[$i] $archlist[$j] # include in the list ony if there is no duplicate name1.name2 already in the filesNoExt (leaves name1 if there is no .name2)
			end
		end
		if test $DebugVar -eq 1
			echo "Test: i=$i; " '$archivelist_ref[$i]=$$ ' $archivelist_ref[$i] ":" $$archivelist_ref[$i]
		end
	end

	set filesNumber (count $filesNoExt)
	for i in (seq $filesNumber)
		# set i 7
		set -l nm $filesNoExt[$i]	 # Local var with file name without extension
		# Exclude duplicates: given that the filesNoExt list is sorted, finding a match in the elements following the current one (e.g. [$i]'foo'{'foo.bar'} (fileNoExt 'foo' including a match with a 'foo.bar' file), but there is also [$i+1]'foo.bar'{foo.bar, foo.bar.baz}, so the 'foo'{'foo.bar'} is a duplicate, 'foo.bar' file should only be in the second list and removed from the first
		set -l removeIndex
		for j in (seq (count $$archivelist_ref[$i])) # test each match against all fileNoExt elements following $i
			if test $DebugDup -eq 1; echo "i=$i; j (count" '$$archivelist_ref[$i])='(count $$archivelist_ref[$i]); end
			if test $DebugDup -eq 1; echo '$archivelist_ref['"$i]:" $archivelist_ref[$i] '$$archivelist_ref['"$i]:" $$archivelist_ref[$i]; end
			if test $i -lt $filesNumber
				set k $i
				if string match -r "^$$archivelist_ref[$i][$j]\$" $filesNoExt[(math $k+1)..(count $filesNoExt)] 1>/dev/null
					if test $DebugDup -eq 1
						echo "Test: ↑↑↑ this was a match ↑↑↑"
						echo "Test: i=$i; j=$j; " '$$archivelist_ref[$i][$j]=' $$archivelist_ref[$i][$j]
						echo "Test: ==pre removal== " '$$archivelist_ref[$i]=' $$archivelist_ref[$i]
					end
						set $archivelist_ref[$i][$j] "" # set the element empty (can't remove here yet, will break array element numbers)
						set removeIndex $removeIndex $j
					if test $DebugDup -eq 1; echo "Test: ==post removal== " '$$archivelist_ref[$i]=' $$archivelist_ref[$i]; end
				end
			end
		end
		for j in (seq (count $removeIndex)); set -e $archivelist_ref[$i][(math $removeIndex[$j]-$j+1)]; end # actually remove elements
		set archive $$archivelist_ref[$i]
		set archiveNumber (count $$archivelist_ref[$i])
		set archivelist_ext (string replace -r "^($nm\.|$nm)" "." $$archivelist_ref[$i]) # replace file name with a period, leaving only .ext
		if test -n "$archive" # test if file list to be included in the archive isn't empty (after duplicates were removed)
			printf "\r%-*s %-s %-s{%-s}\n" "$f_ArrayMinMax_Max" "$nm" ".zip =" "$archiveNumber" "$archivelist_ext"
			# echo "will be zipped" "$nm.zip:" "$$archivelist_ref[$i]"
			if test $DebugZip -eq 1
				zip -v "$nm.zip" $$archivelist_ref[$i] # verbose
			else if test $ZipLog -eq 0
				printf "\n\r%-*s %-s %-s{%-s}\n" "$f_ArrayMinMax_Max" "$nm" ".zip =" "$archiveNumber" "$archivelist_ext" 1>>"$ZipLogName"
				zip -v "$nm.zip" $$archivelist_ref[$i] 1>>"$ZipLogName"
			else
				zip -q "$nm.zip" $$archivelist_ref[$i]
			end
		end
	end
	if test $ZipLog -eq 0; echo Output written to "$ZipLogName"; end
end
