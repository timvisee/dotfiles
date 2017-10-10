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

# Clean up Docker, by removing all containers and images
function docker_clean_all
    echo "Cleaning Docker..."

    docker_rm_all
    docker_clean

    # Remove the ever increasing Docker image file from macOS
    if [[ `uname -s` == "Darwin" ]]
        rm -f ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2
    end

    echo "Done"
end

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

# Enable GPG signing for a repository
#
# First, this function sets the GPG key to use for signing commits,
# based on the given signature.
#
# Then, this function enables automatic signing for commits,
# so the flag -S doesn't have to be supplied when committing.
#
# $1: ID of the GPG key to use
function git_enable_gpg
    # Make sure a key is entered
    if test -z "$argv[1]"
        echo "Please provide a GPG key ID!"
        echo "  git_enable_gpg [GPG_ID]"
        return 1
    end

    # List the key by it's ID
    echo "Checking the GPG key ID..."
    gpg --list-keys $argv[1]

    # Report, return if the key is invalid
    if test $status -ne 0
        echo "Invalid GPG key ID!"
        return 1
    end

    echo "Enabling GPG signing..."

    # Set the signing key
    git config user.signingKey $argv[1]

    # Enable signing by default
    git config commit.gpgsign true

    echo "Done"
end

# Set the preferred editor
set -x EDITOR vim

# GPG key
set -x GPG_TTY (tty)
