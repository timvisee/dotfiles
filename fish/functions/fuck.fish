# The fuck alias

# Make sure thefuck is installed
if test ! -e /usr/bin/thefuck
    echo "thefuck is not installed"
    exit 1
end

# Set up the alias
#thefuck --alias | source

# Alternative, as the above alias is currently broken
function fuck -d "Correct your previous console command"
    set -l fucked_up_command $history[1]
    env TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command | read -l unfucked_command
    if [ "$unfucked_command" != "" ]
        eval $unfucked_command
        builtin history delete --exact --case-sensitive -- $fucked_up_command
        builtin history merge ^ /dev/null
    end
end
