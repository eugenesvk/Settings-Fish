function l -w ls -d 'A shortcut to ls -al –color=always with added octal permissions'
  #ls -lah --color=always $argv
  ls -lah --color=always $argv | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
             *2^(8-i));if(k)printf("%0o ",k);print}'
end
