function psg -d "Details on a given process with table headers retained (ps aux | grep $argv); use [a]rgv to avoid showing grep command or add grep -v grep"
  if test -z $argv    # no arguments
		ps axu | grep -v grep | grep '[C]OMMAND\|'
	else if test (string length "$argv") -eq 1       # argument of 1 character length
		ps axu | grep -v grep | grep '[C]OMMAND\|'"$argv"
	else
		set -l argv1st (string sub -l1 $argv); set -l argvrest (string sub -s2 $argv)	#separate first char
		ps axu | grep '[C]OMMAND\|'"[$argv1st]$argvrest"
	end
  # show detailed table of processes matching description; [] avoids catching COMMAND in self, you'd still have to enclose relevant $argv part in [] to avoid catching self by your argument. Grep would trip over [] in self
	# -a: all users, no group leaders (1st member of a group of related processes), no processes without controlling terminal
	# -x: adds processes without controlling terminal, such as daemons (launched during boot and run in the background)
	# -u: detailed information about each process
end
