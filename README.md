     ______                       _   _____        _    __ _ _           
    |  ____|                     ( ) |  __ \      | |  / _(_) |          
    | |__ ___ _ __ __ _ _   _ ___|/  | |  | | ___ | |_| |_ _| | ___  ___ 
    |  __/ _ \ '__/ _` | | | / __|   | |  | |/ _ \| __|  _| | |/ _ \/ __|
    | | |  __/ | | (_| | |_| \__ \   | |__| | (_) | |_| | | | |  __/\__ \
    |_|  \___|_|  \__, |\__,_|___/   |_____/ \___/ \__|_| |_|_|\___||___/
                   __/ |                                                 
                  |___/                                                  

Yes I am that childish

My Linux dotfiles. Initialise the repo using the following shell command:

    cd ~ &&
    git init &&
    git remote add origin https://github.com/C-Fergus/dotfiles.git &&
    git pull origin master

This will pull the repo into your home directory, allowing them to be used immediately. I will change this so that it will create a symbolic link to the files in the home directory while the repo can be stored in ~/dotfiles/ when I am finished creating them.
