# crashcreator
a game for crash fans to create and play on their own levels, and free source code ;)

# Working Godot Version
    - 3.2 beta 4 - Standard

# WARNING
alpha - means not playable... yet!

### Alpha 0.9.4
    - Remade all level editor system
    - Added Entity Editor (place where level start and finish)
    - Made the level build system to test
    - Some adjustments to level models
    - About the Addon/cw_pathgen
        - https://github.com/nonunknown/crashcreator/wiki/Addon-PathGen

### Alpha 0.9.3 - The Level Editor update
    - Added all buttons refering to tools
    - Added 15 differents paths for toad village
    - Added crate editor
    - Changed the editor managing system
    - levels now can go upwards and downwards

### Alpha 0.9.2 - The 2nd BIG Crash update
    - Added a performance like state machine to player
        - can be found at character.gd
        - the Utils state machine is no longer used (deleted soon)
    - Finally done correct rotation to character (lot of research)
        -refer to https://github.com/godotengine/godot-demo-projects/pull/369
    - 90% done the character just a few more animations (made yet but not programmed)
    - Added LabGameplay scene just to test character and camera
    - Camera now look at the player smoothly

### Alpha 0.9.1
    - More Animations to crash
        - Run
        - Barricata
        - Portal Jump

### Alpha 0.9.0 - Beta here we go \o/
    - Started implementing the warp room
    - Crash now has footsteps(TODO: add each ground tipe sound)
    - Some improvements on camera and crash anims
    - Godot version added

### Alpha 0.8.9
    - Corrected some character bugs
    - Added Head collision check with crates
    - Added twist animation to crash
    - adjusted crash animations (a lot to do yet)
    - Added more sounds


### Alpha 0.8.8
    - Updated Aku (Performance reasons)
    - Added Crates:
        - Nitro
        - Bounce
    - Created Iventory for crash(wumpa,life,crates)
    - Added more sounds


### Alpha 0.8.7
    - Updated Crash & Aku as health system
    - Remade crate box system
    - Remodeled crate, due to inverted UV and added bounce shape key
    - Updated Explosion resource

### Alpha 0.8.6 - The Crash Update
    - Updated visual debug (just call set_text now)
    - Added More animations to crash
    - Remove the BUG where crash animations doesnt play
    - other minor adjustments on crates 
    - Updated Character.gd code (more organized and implemented new features)

### Alpha 0.8.5 - The Aku Update
    - Added visual debug text on screen
    - Implemented TNT
    - Crates now has a base crate node, due to facility to create new ones and edit them
    - Added Aku aku system (Best one)
    - Did almost all crash animations (not the best thing in the world but for a programmer...)
        - TODO: Solve non animating bug (try to export GLTF)
    - Implemented Wumpa

### Alpha 0.8.4
    - Improved Selection
    - Improved collision
    - Updated Utils.gd
        - file_exists(path)
        - enum MASK
        - function ray() now has a collision_mask param
    - Important
        The old save/load system was changed from *.JSON to *.SCN(built-in) due to facility of
        building user made levels


### Alpha 0.8.3
    - Added new Level model
    - Improved Path System
        - The paths now can have custom Z sizes (before was just X,Y)
    
### Alpha 0.8.2
    - Moved the project to GODOT 3.2 beta3
    - Updated GUI
    - Add new paths by selecting them
### Alpha 0.8.1
    - Improved GUI System

### Alpha 0.8
    - Started GUI System
    - Started GAMEMODE System
    - Improved Selection System using State Machines
