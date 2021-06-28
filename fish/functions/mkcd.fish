# Make a directory and change to it
function mkcd --description "Make a directory and change to it"
    # Make the directory
    mkdir $argv

    # Change to the newly created directory
    and cd $argv
end
