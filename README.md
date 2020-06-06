     ______                       _   _____        _    __ _ _           
    |  ____|                     ( ) |  __ \      | |  / _(_) |          
    | |__ ___ _ __ __ _ _   _ ___|/  | |  | | ___ | |_| |_ _| | ___  ___ 
    |  __/ _ \ '__/ _` | | | / __|   | |  | |/ _ \| __|  _| | |/ _ \/ __|
    | | |  __/ | | (_| | |_| \__ \   | |__| | (_) | |_| | | | |  __/\__ \
    |_|  \___|_|  \__, |\__,_|___/   |_____/ \___/ \__|_| |_|_|\___||___/
                   __/ |                                                 
                  |___/                                                  

Yes I am that childish

My Linux dotfiles. Initialise the repo using the following shell command set:

    cd &&
    git clone https://github.com/C-Fergus/dotfiles.git &&
    bash ~/dotfiles/runonce.sh

This will pull the repo into a folder in your home directory (~) named "dotfiles" and run the interactive new install script to make symbolic links of all necessary files in ~, as well as installing from the default app list in 'aptgetInstall.sh', which can be edited before running.
Alternatively, the files can pulled directly into a repo in the home directory using the following command set:

    cd ~ &&
    git init &&
    git remote add origin https://github.com/C-Fergus/dotfiles.git &&
    git pull origin master &&
    bash aptgetInstall.sh

This will pull the repo directly into ~ allowing them to be used immediately, as well as running the installation script.
