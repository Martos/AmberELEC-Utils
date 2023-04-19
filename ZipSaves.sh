#!/bin/bash

clearScreen() {
    echo -e '\033[?25h\033[?16;224;238c' > /dev/console
    clear > /dev/console
}

RED='\033[0;31m'
NC='\033[0m'

clearScreen

echo -e "Create ${RED}ZIP${NC} for saves... \n" > /dev/console
find ./ -type f -name "*.srm" -o -name 'sm64_save_file.bin' | zip -@ /storage/roms/ports/$(date +"%Y%m%d")_saves.zip > /dev/console

echo -e "\nDone. Closing in 5 seconds." > /dev/console
sleep 5

clearScreen

exit 0