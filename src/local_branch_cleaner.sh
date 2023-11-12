#!/bin/bash

# Read the whitelist file into an array
whitelist=()
while IFS= read -r line; do
    whitelist+=("$line")
done < lbc_whitelist.txt

# Helper function to check if a branch is whitelisted
is_whitelisted() {
    local branch=$1
    for item in "${whitelist[@]}"; do
        [[ "$branch" == "$item" ]] && return 0
    done
    return 1
}

# For every directory in the current folder
for dir in */ ; do
    # Check if it's a git repository
    if [ -d "$dir/.git" ]; then
        echo "Checking $dir"
        cd "$dir"

        # Fetch the latest changes from origin without changing local state
        git fetch -p

        # For each local branch
        for branch in $(git branch --format '%(refname:short)'); do
            # Check if the branch is whitelisted
            if is_whitelisted "$branch"; then
                echo "$branch is whitelisted, skipping."
                continue
            fi

            # Check if the branch exists on origin
            if ! git show-ref --verify --quiet refs/remotes/origin/$branch; then
                # If the branch doesn't exist on origin, delete it locally
                echo "$branch would have been deleted" #git branch -D $branch
            fi
        done

        cd ..
    fi
done

echo "Inspect the list above. If it looks good, uncomment line 39 in the local_branch_cleaner.sh script and re-run."

