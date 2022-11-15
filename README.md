# RPI-LightGun-Tool
WORK IN PROGRESS

## Info 

         This is a tool to make using Lightguns on Retropie as easy as possible.
         
         Version:                BETA 1.01
         
         Last Update:            11/5/22

## FEATURES 

          Grabs a pre setup retroarch-gun.cfg file for Retroarch systems.

          Grabs or edits files on standalone emu configs.

          Make new folders for gun games. 

          Ask what type of gun your using, & loads different menus for different guns.
          
          Makes a new "emulator" in retropie, called systemname-gun. ex nes-gun

## INSTALLATION

          WARNING BETA FOR DEV ONLY ATM. AGAIN WARNING BETA 

          curl -sSL bit.ly/Install-RPI-LG-Tool | bash

## HOW TO USE?

- In Retropie

            1.Go to Retropie/Config
            
            2.Launch RPI Lightgun Tool 
            
            3.Select Gun Type

            4.Select system/console

            5.Press A/Enter

            6.Select From The Options 
            
            
- From Command Line/Terminal

            1.Type "RPI-Lightgun-Tool" 
                        
            2.Press Enter
            
            3.Select Gun Type
            
            4.Select system/console

            5.Press A/Enter

            6.Select from the options
## FAQ

- Where does it make new folder for gun games ?
      
      home/pi/RetroPie/roms/"systemname"/gun-games/
      
- What is new configs called? Where are they at?

      The new retroarch config is located at 
      
                  /opt/retropie/configs/systemname/retroarch-gun.cfg  
                  
      The new edited emulators.cfg is located at
      
                  /opt/retropie/configs/systemname/emulators.cfg
                  
      Your emulators.cfg backup is located at 
                  
                  /opt/retropie/configs/systemname/emulators-cfg.backup
      
- What gun(s) is this for ?
      
      - Aimtrack(untested, Unlikely)
      - AE Lightgun
      - Dolphin Bar with Wii mote
      - Gun4IR Lightgun
      - Infared Mouse Input Guns
      - Sinden Lightgun


- How do I undo the changes the script made?

         - Open RPI Lightgun Tool
         
         - Click Gun Type
         
         - Click on ---UNDO MENU---
         
         - Select system youd like to undo
         
         
# Credits 

Sinden Credits 
         
         Configuration Files
         
         Widge-5
         
         https://github.com/Widge-5/sinden-barebones-configs
         
         
         
         Setup Script 
         
         SindenLightGun
         
         https://github.com/SindenLightgun/SindenLightgunLinux
         
         
Testing Credits

         COMING SOON
