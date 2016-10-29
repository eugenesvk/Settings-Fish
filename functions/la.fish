function la --description "List contents of directory, including hidden files in directory using long format + octal permissions"
	#ls -lah $argv
	ls -lah $argv | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
             *2^(8-i));if(k)printf("%0o ",k);print}'
end
