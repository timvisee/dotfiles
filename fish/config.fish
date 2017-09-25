# Fish shell configuration

# Source other configuration files
source ~/.config/fish/aliases.fish
source ~/.config/fish/nvm.fish
source ~/.config/fish/prompt.fish
source ~/.config/fish/transfer.fish

# Disable fish greeting
set fish_greeting

# Add rust binaries to the path
if test -d "$HOME/.cargo/bin"
    set PATH $HOME/.cargo/bin $PATH
end

# Configure Go's environment
if test -d "/usr/lib/go"
    set -x GOROOT /usr/lib/go
    set -x GOPATH $HOME/.go
    set -x PATH $PATH $GOROOT/bin
end

# Configure composer
if test -d "$HOME/.composer/vendor/bin"
    set -x PATH $PATH $HOME/.composer/vendor/bin
end

# Remove all Docker containers
function docker_remove_containers
    echo "Removing all Docker containers..."
    docker rm (docker ps -aq)
    echo "Done"
end

# Clean Docker, by removing things like dangling images.
function docker_clean
    set DANGLING_IMAGES (docker images -f "dangling=true" -q)
    if [ $DANGLING_IMAGES ]
        echo "Cleaning up dangling Docker images..."
        docker rmi $DANGLING_IMAGES
    else
        echo "No dangling Docker images to remove"
    end

    set DANGLING_VOLUMES (docker volume ls -f "dangling=true" -q)
    if [ $DANGLING_VOLUMES ]
        echo "Pruning all unused Docker volumes..."
        docker volume prune -f
    else
        echo "No dangling Docker volumes to prune..."
    end

    echo "Done"
end

# Clean up Docker, by removing all containers and images
function docker_clean_all
    echo "Cleaning Docker..."

    docker_remove_containers
    docker_clean

    # Remove the huge Docker.qcow2 image from Mac OS X systems
    rm -f ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2

    echo "Done"
end

# Set the preferred editor
set -x EDITOR vim
