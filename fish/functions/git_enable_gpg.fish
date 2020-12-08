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
