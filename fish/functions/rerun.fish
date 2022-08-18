function rerun --description "Rerun command when directory contents change"
    while true
        reset
        $argv
        inotifywait -e MODIFY --recursive .
    end
end
