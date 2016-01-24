#This will run the mkdir command, and if it is successful, change the current working directory to the one just created
function mkd -d "Create a directory and CD to it"                #`-d` add description
    command mkdir $argv
    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end
