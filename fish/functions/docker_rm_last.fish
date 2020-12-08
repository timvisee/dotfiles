# Remove the last created container.
function docker_rm_last
    set LAST_CONTAINER (docker ps -lq --no-trunc)
    if test -n "$LAST_CONTAINER"
        echo "Removing the last created Docker container..."
        docker rm $LAST_CONTAINER
    else
        echo "No last Docker container to remove"
    end

    echo "Done"
end
