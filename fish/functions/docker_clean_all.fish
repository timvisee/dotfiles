# Clean up Docker, by removing all containers and images
function docker_clean_all
    echo "Cleaning Docker..."

    docker_rm_all
    docker_clean

    # Remove the ever increasing Docker image file from macOS
    if [ (uname -s) = "Darwin" ]
        rm -f ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2
    end

    echo "Done"
end
