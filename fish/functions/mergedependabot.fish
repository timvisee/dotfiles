function mergedependabot -d "Merge a dependabot PR into a GitLab repository" -a local_branch -a remote_branch
    # Ensure arguments are given
    test -z $local_branch && echo Missing argument: local branch && return 1
    test -z $remote_branch && echo Missing argument: remote branch && return 1

    set -l branch (git branch --show-current)
    set -l remote_branch (echo $remote_branch | sed 's/^origin\//github\//')

    # We must be on master now
    if test $branch != "master"
        echo "Currently not in master branch, refusing to merge"
        exit 1
    end

    echo Merging remote "'$remote_branch'" into master...

    git fetch github
    and git checkout -b "$local_branch" "$remote_branch"
    and git merge master

    and git checkout master
    and git merge --no-ff "$local_branch" -e -m "Merge branch '$local_branch' into master"
    # and git push --no-verify

    and git branch -d "$local_branch"

    echo "Merged into master, use 'git push' to publish"
end
