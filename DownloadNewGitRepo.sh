#!/bin/bash

# Check if Git is installed
git --version >/dev/null 2>&1
if [ $? -ne 0 ]
then
    echo "Git is not installed."
    read -p "Would you like to download the git installer? yes/no: " response

    if [ "$response" = "yes" ]
    then
        echo "Downloading Git installer..."
        # Download the Git installer (assuming you have curl installed)
        curl -L -o git_installer.exe https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.1/Git-2.32.0-64-bit.exe

        echo "Please run the downloaded installer 'git_installer.exe' to install Git."
        echo "Run updater again after installed."

        ./git_installer.exe
    else
        echo "Not able to update repository without git"
        exit 1
    fi
fi

read -p "Enter the Git Repository URL ending in .git: " url

# Get the repository name from the URL
if [[ $url == *.git ]]
then
    IFS='/'
    read -ra url_parts <<< "$url"
    IFS=' '
    username="${url_parts[-2]}"
    repo="${url_parts[-1]}"
    repo=${repo%.*}

    # Print the repository name
    echo "Cloning $repo"

    # Clone the repository
    git clone "$url"

    # Move into the directory
    cd "$repo"

    (
        echo "#!/bin/bash"
        echo "git pull $url"
        echo "if [ -f requirements.txt ]; then"
        echo "    pip install -r requirements.txt"
        echo "else"
        echo "    echo no requirements.txt for this repo"
        echo "fi"
    ) > updater.sh
    chmod +x updater.sh
else
    echo "This is not a git URL."
    exit 1
fi
