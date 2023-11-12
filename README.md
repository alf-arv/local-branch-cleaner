# local-branch-cleaner
Utility script helping you clean stale and (on remote) already merged branches from your local machine (with whitelist support) 🌲🪵 This script is helpful for those who work in lots of repositories, as this tends to lead to a mess of redundant local branches after some time.

Feel free to take inspiration from, modify or improve this small project to your liking without notice to me.

## How it works
This script inspects all subdirectories for a *.git* file, compares the existing branches on remote with the ones on the local machine, and deletes the local one if it is not listed in the protected whitelist *lbc_whitelist.txt*. The end result is a cleanly wiped local machine leaving only the currently checked out local branches and branches still existing on remote.

### Example file structure
```
.
├── local_branch_cleaner.sh
├── lbc_whitelist.txt
├── personal-project-1/
│   ├── .git
│   └── ...
├── work-project-1/
│   ├── .git
│   └── ...
├── work-project-2/
│   ├── .git
│   └── ...
└── ...
```


## Installation
1. **Run the following code block in your git repo root directory**. This will download both the script and whitelist file, move them to the correct place, and remove any redundant temporary files:
```
git clone -n --depth=1 --filter=tree:0 \
  https://github.com/alf-arv/local-branch-cleaner
cd local-branch-cleaner
git sparse-checkout set --no-cone src
git checkout
mv ./src/local_branch_cleaner.sh ../
mv ./src/lbc_whitelist.txt ../
cd ..; rm -rf local-branch-cleaner
```
2. Add any protected branch names in the *lbc_whitelist.txt* file

3. Run the script by running the *local_branch_cleaner.sh*. It will automatically run in safe mode and show an output of the change plan, a re-run is needed to actually delete anything
