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
    echo "Cleaning up dangling Docker images..."
    docker rmi (docker images -f "dangling=true" -q)
    echo "Done"
end

# Clean up Docker, by removing all containers and images
function docker_clean_all
    echo "Resetting Docker..."

    docker_remove_containers
    docker_clean

    rm -f ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2

    echo "Done"
end

# Set the preferred editor
set -x EDITOR vim
