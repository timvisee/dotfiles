# Clean Docker, by removing things like dangling images.
function docker_clean
    set DANGLING_IMAGES (docker images -f "dangling=true" -q --no-trunc)
    if test -n "$DANGLING_IMAGES"
        echo "Cleaning up dangling Docker images..."
        docker rmi $DANGLING_IMAGES
    else
        echo "No dangling Docker images to remove"
    end

    set DANGLING_VOLUMES (docker volume ls -f "dangling=true" -q)
    if test -n "$DANGLING_VOLUMES"
        echo "Pruning all unused Docker volumes..."
        docker volume prune -f
    else
        echo "No dangling Docker volumes to prune"
    end

    echo "Done"
end
