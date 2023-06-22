:: This script does the following:

:: Checks if Git is installed
:: Sets the variable url to the git clone URL.
:: Uses the for /f command to split the URL into parts and get the username and repository name.
:: Prints the repository name to the console.
:: Clones the repository.
:: Moves into the directory.
:: Note: The for /f command splits the string into tokens based on the specified delimiters. Here, /, . and (space) are used as delimiters. tokens=4-5 instructs it to take the fourth and fifth parts of the string, which correspond to the username and repository name. The ~ symbol in %%~a and %%~b removes any enclosing quotes from the variable value.

@echo off
setlocal enabledelayedexpansion


:: Check if Git is installed
git --version >NUL 2>NUL
IF %ERRORLEVEL% NEQ 0 (
   echo Git is not installed. 
   set /P response=Would you like to download the git installer? yes/no: 

   if  /I "!response!" == "yes" (
       echo Downloading Git installer...
       :: Download the Git installer (assuming you have curl installed)
       curl -L -o git_installer.exe https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.1/Git-2.32.0-64-bit.exe

       echo Please run the downloaded installer 'git_installer.exe' to install Git.
       echo Run updater again after installed.

       start git_installer.exe
   ) else (
       echo Not able to update repository without git
       goto :End
   )
) else (



    set /P url=Enter the Git Repository URL ending in .git: 

    set "lastfour=!url:~-4!"
    if /i "!lastfour!"==".git" (
        rem echo This is a git URL.
    ) else (
        echo This is not a git URL.
        goto :End
    )

    :: Get the repository name from the URL
    for /f "tokens=4-5 delims=/. " %%a in ("!url!") do (
        set "username=%%~a"
        set "repo=%%~b"
    )

    :: Print the repository name
    echo Cloning !repo!

    :: Clone the repository
    git clone !url!

    :: Move into the directory
    cd !repo!

    (
        echo @echo off
        echo setlocal enabledelayedexpansion

        echo ::Uncomment if you would like to update pip and git before updating gpt-engineer
        echo ::python -m pip install --upgrade pip
        echo ::git update-git-for-windows
        echo git pull !url!
        echo pip install -r requirements.txt

        echo endlocal
        echo pause
    ) > updater.bat

)

:End
pause
