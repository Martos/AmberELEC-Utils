#!/bin/bash

export SDL_GAMECONTROLLERCONFIG_FILE="/storage/.config/SDL-GameControllerDB/gamecontrollerdb.txt"
source /usr/bin/env.sh
export TERM=xterm-color
export DIALOGRC=/etc/amberelec.dialogrc
echo -e '\033[?25h\033[?16;224;238c' > /dev/console
clear > /dev/console

gptokeyb ZipSavesGUI.sh -c /usr/config/gptokeyb/settime.gptk &

OUTPUT=$(find ./ -type f -name "*.srm" -o -name 'sm64_save_file.bin' | wc -l)

dialog --title "ZIP Utils" --yesno $OUTPUT" saves found. Do you want to create a ZIP ?" 7 60 --clear -no-cancel > /dev/console

if [ $? -eq 255 ]
then
  find ./ -type f -name "*.srm" -o -name 'sm64_save_file.bin' | zip -@ /storage/roms/ports/$(date +"%Y%m%d")_saves.zip \
    | awk -v files=$OUTPUT 'BEGIN {count=0;percentage=0;} {count=count+1;percentage=((count*100)/files);print int(percentage)}' \
    | dialog --title "ZIP Utils" --gauge "Compressing "$OUTPUT" files" 20 70 0 --clear > /dev/console
    
  dialog --title "ZIP Utils" --msgbox "Zip created: "$(date +"%Y%m%d")_saves.zip 10 35 --clear --no-cancel > /dev/console
fi

kill -9 $(pidof gptokeyb)
echo -e '\033[?25l' > /dev/console
clear > /dev/console
exit 0