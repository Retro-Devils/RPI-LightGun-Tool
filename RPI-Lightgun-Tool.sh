#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="<-----RPI LIGHTGUN TOOL -----><->Version<->1.01"

function gun-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 40 60 40 \
      1 "Dolphin/WII Mote" \
      2 "Gun4IR Lightgun" \
      3 "Infared Mouse Gun" \
      4 "Sinden Lightgun" \
      T1 "---ABOUT  RPI-LG-TOOL---" \
      T2 "---REMOVE RPI-LG-TOOL---" \
      T3 "---UPDATE RPI-LG-TOOL---" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) dolphin-bar  ;;
    2) soon  ;;
    3) soon ;;
    4) sinden-menu ;;
    T1) gun-help ;;
    T2) remove-script ;;
    T3) update-script ;;
     *) break ;;
    esac
   done
}

######--------------------------------------------------------TEMPORARY----------------------------------------------------------------------------------#####

function soon() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
COMING SOON TO MY FRIEND
APPRECIATE THE WAIT" 0 0 
}

######--------------------------------------------------------SCRIPT TOOLS----------------------------------------------------------------------------------#####

function gun-help() {
dialog  --sleep 1 --title "---RPI LIGHTGUN TOOL HELP---" --msgbox "

___________BASIC INSTRUCTIONS__________
- PICK YOUR GUN TYPE
- ALL GUN TYPES WILL LOAD A SUB MENU
- MOST SUB MENUS WILL BE A SYSTEMS LIST
- PRESS A/ENTER TO CONFIGURE SYSTEM

I DONT LIKE THIS . HOW DO I UNDO IT?
- GO BACK TO GUN TYPE SUBMENU
- CLICK -----UNDO MENU----
- SELECT SYSTEM TO UNDO" 0 0
dialog  --sleep 1 --title "---FAQ---" --msgbox "
- WHERE DO I PUT GAMES?
----PLACE YOUR GAMES IN .../roms/systemname/gun-games/
- WHY DONT GAMES I ADDED SHOW?
----MAKE SURE RETROPIE CAN SEE FOLDERS.
- WHY DIDNT GUN WORK IN GAME?
----MAKE SURE TO SELECT systemname-gun AS EMU. " 0 0
}

function remove-script() {
sudo rm $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo rm /usr/local/bin/RPI-Lightgun-Tool
}

function update-script() {
if [ -f "$HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh" ]; then sudo rm $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh; fi
if [ -f "/usr/local/bin/RPI-Lightgun-Tool" ]; then sudo rm /usr/local/bin/RPI-Lightgun-Tool; fi
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/RPI-Lightgun-Tool.sh -P $HOME/RetroPie/retropiemenu/
sleep 1
sudo cp $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh -f /usr/local/bin/RPI-Lightgun-Tool
sleep 1
chmod 755 $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo chmod 755 /usr/local/bin/RPI-Lightgun-Tool
}

#---------------------------------------------------------------GUN4IR---------------------------------------------------------------#
function gun4ir() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI GUN4IR SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO LOAD CONSOLE MENU" 40 60 40 \
      1 "Gun4IR Offical Firmware" \
      2 "Console Selection" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) offical-gun4ir ;;
    2) gun4ir-consoles  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function offical-gun4ir() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
- This is a gui for windows not linux(retropie).
- You might be able to run through wine, untested thus far.
- To our knowledge you do NOT need it for pi." 0 0
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI GUN4IR SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SELECT" 40 60 40 \
      1 "Download Firmware and GUI" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) gun4ir-firm  ;;
    -) no ;;
     *) break ;;
    esac
   done
}


function gun-firm() {
wget https://github.com/gobozgz/GUN4IR/archive/refs/tags/2.16.zip -P "$HOME"
unzip 2.16.zip
}

#--------------------------------------------------------------DOLPHIN BAR---------------------------------------------------------------------------------------#

function dolphin-bar() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "DOLPHIN BAR/WII MOTE MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) nes-wii ;;
    2) model3 ;;
    3) dolphin-bar-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function nes-wii() {
if [ ! -d "/opt/retropie/configs/nes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 777 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
#sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/nes/emulators.cfg -P /opt/retropie/configs/nes/
if [ ! -f "/opt/retropie/configs/nes/confirm-gun" ] ; then
sed -i '/default/a nes-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/nes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called nes-gun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO nes-gun" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
}

function snes-wii() {
if [ ! -d "/opt/retropie/configs/snes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 777 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
#sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/snes/emulators.cfg -P /opt/retropie/configs/snes/
if [ ! -f "/opt/retropie/configs/snes/confirm-gun" ] ; then
sed -i '/default/a snes-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/snes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/snes/gun-games/ 
- A new emu called snes-gun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO snes-gun" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
}



function dolphin-bar-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "WII MOTE UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo NES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "nes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}

#--------------------------------------------------------------IR MOUSE GUN-------------------------------------------------------------------------------------------------------#

function mouse-gun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "IR MOUSE GUN MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) nes-mouse ;;
    2) model3 ;;
    3) mouse-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function nes-mouse() {
if [ ! -d "/opt/retropie/configs/nes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 755 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
#sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/nes/emulators.cfg -P /opt/retropie/configs/nes/
if [ ! -f "/opt/retropie/configs/nes/confirm-gun" ] ; then
sed -i '/default/a "nes-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/nes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called nes-gun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO nes-gun" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
}

function snes-mouse() {
if [ ! -d "/opt/retropie/configs/snes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 755 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
#sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/snes/emulators.cfg -P /opt/retropie/configs/snes/
if [ ! -f "/opt/retropie/configs/snes/confirm-gun" ] ; then
sed -i '/default/a "snes-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/snes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/snes/gun-games/ 
- A new emu called snes-gun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO snes-gun" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
}

function mouse-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "IR MOUSE UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo NES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "nes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}



####--------------------------------------------------------------------------------Multi guns-----------------------------------------------------------------------####

function undo-retroarch() {
if [ ! -f "/opt/retropie/configs/"$1"/retroarch-gun.cfg" ]; then 
dialog  --sleep 1 --title "ERROR ERROR" --msgbox "
- RPI LIGHTGUN TOOL HASNT TOUCHED THIS SYSTEM
- IT CANNOT UNDO WHAT IT DIDNT DO LOL
- EXITING NOW" 0 0
else
sudo rm /opt/retropie/configs/"$1"/emulators.cfg
sudo mv /opt/retropie/configs/"$1"/emulators-cfg.backup /opt/retropie/configs/"$1"/emulators.cfg
sudo rm /opt/retropie/configs/"$1"/retroarch-gun.cfg
sudo rm /opt/retropie/configs/"$1"/emulators.cfg.bak.cfg
fi
}

function emu-error() {
dialog  --sleep 1 --title "EMULATOR ERROR" --msgbox "
- YOU DO NOT HAVE THE CORRECT EMU INSTALLED
- TOOL CANT CONFIGURE A EMU NOT THIER
- EXITING NOW" 0 0
}

####--------------------------------------------------------------------------------------------SINDEN------------------------------------------------------------------####

function sinden-menu() {
if [ ! -d "$HOME/SindenLightgunLinux" ]; then
dialog  --sleep 1 --title "CREDITS" --msgbox "
- ALL CREDIT GOES TO 
https://github.com/SindenLightgun/SindenLightgunLinux
- WE JUST ADDED THOSE SCRIPTS IN UI" 0 0
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "SINDEN SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PLEASE SELECT A OPTION" 40 60 40 \
      1 "INSTALL SINDEN DRIVERS " \
      2 "CONFIGURE SINDEN GUN" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) sinden-install ;;
    2) sinden-config ;;
    -) no ;;
     *) break ;;
    esac
   done
else
sinden-consoles 
fi
}

function sinden-config() {
if [ ! -d "$HOME/SindenLightgunLinux" ]; then
dialog  --sleep 1 --title "MISSING SINDEN DRIVERS" --msgbox "
- SINDEN DRIVERS/SOFTWARE NOT INSTALLED
- CANT CREATE GUN CONFIG WITHOUT DRIVERS 
- EXTING " 0 0
else
cd /home/pi/SindenLightgunLinux; \
chmod 755 *.sh; \
./setup-lightgun.sh; \
./setup-retropie.sh; \
fi
}


function sinden-install() {
if [ ! -d "$HOME/SindenLightgunLinux" ]; then
cd /home/pi; \
git clone https://github.com/SindenLightgun/SindenLightgunLinux.git; \
cd SindenLightgunLinux; \
echo ""; \
VERSION=$(git symbolic-ref --short -q HEAD); echo "Current Version ${VERSION}"
else
cd /home/pi/SindenLightgunLinux
git pull
fi
}


function sinden-consoles() {
dialog  --sleep 1 --title "COMING SOON" --msgbox "
- COMING SOON
- PLEASE WAIT LOL" 0 0
}
###---------------------------------------------------------------------STANDALONES--------------------------------------------------------------------###

function model3() {
if [ ! -d "opt/retropie/configs/model3" ]; then
dialog  --sleep 1 --title "MISSING EMU ERROR" --msgbox "
- SUPER MODEL 3 IS NOT INSTALLED 
- CANT CREATE GUN CONFIG WITHOUT EMU 
- EXTING " 0 0
else
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/sa-configs/all/model3/supermodel.ini -P
fi
}




gun-menu
