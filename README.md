# GitShellUpdater
These are shell scripts that clones a repo and provides another updater shell script file to keep the newly downloaded repo up-to-date.

## Goal
- Make downloading and updating repos more streamlined

## Usage
- Place the DownloadNewGitRepo shell script into a folder you want to contain your git repositories
- Run `DownloadNewGitRepo.bat` if on windows or `DownloadNewGitRepo.sh` if on MacOS/Linux
- Enter the url for the git repo you want to download ending in .git
- After the new repo is cloned, a new shell script called `updater.bat` or `updater.sh` will be created depending on your OS.

The updater script will pull any new changes and install any new requirements for the repo.
