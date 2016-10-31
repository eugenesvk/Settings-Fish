function gre -d 'Starts and stops PostgreSQL server'
  set PostgreSQLPath /Users/eugenesv/Documents/Dropbox/Database/postgres
  set PostgreSQLLog /Users/eugenesv/Documents/Dropbox/Database/postgres/server.log
  if test -z $argv
		echo no arguments
  else if test $argv = "status"
		brew services list
		#pg_ctl status -D $PostgreSQLPath
		#pg_ctl status -D /Users/eugenesv/Documents/Dropbox/Database/postgres
  else if test $argv = "stop"
		brew services stop postgresql; brew services list
		#launchctl stop ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
		#pg_ctl -D $PostgreSQLPath stop -m fast
		#pg_ctl -D /Users/eugenesv/Documents/Dropbox/Database/postgres stop -m fast
  else if test $argv = "start"
		brew services start postgresql; brew services list
		#launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
		#postgres -D $PostgreSQLPath -r $PostgreSQLLog
  else if test $argv = "restart"
		brew services restart postgresql
  else
		echo "wrong arguments (valid: start, stop, status)"
  end
end