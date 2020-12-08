# Remove all Docker containers
function docker_rm_all
    set DOCKER_CONTAINERS (docker ps -aq --no-trunc)
    if test -n "$DOCKER_CONTAINERS"
        echo "Removing all Docker containers..."
        docker rm $DOCKER_CONTAINERS
    else
        echo "No Docker containers to remove"
    end

    echo "Done"
end
