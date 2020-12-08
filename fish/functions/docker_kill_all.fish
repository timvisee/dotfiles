# Kill all running Docker containers
function docker_kill_all
    set DOCKER_CONTAINERS (docker ps -q --no-trunc)
    if test -n "$DOCKER_CONTAINERS"
        echo "Killing all running Docker containers..."
        docker kill $DOCKER_CONTAINERS
    else
        echo "No Docker containers to kill"
    end

    echo "Done"
end
