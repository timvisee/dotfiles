function auth --description "Authenticate agents"
    # Set-up keychain
    type -q keychain && eval (keychain --eval --quiet --agents ssh,gpg id_rsa)
end
