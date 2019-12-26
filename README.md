# crashcreator
a game for crash fans to create and play on their own levels, and free source code ;)

# WARNING
early alpha - means not playable... yet!

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
