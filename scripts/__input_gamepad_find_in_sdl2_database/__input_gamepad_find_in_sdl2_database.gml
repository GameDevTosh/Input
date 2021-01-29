/// @param gamepadStruct

function __input_gamepad_find_in_sdl2_database(_gamepad)
{
    with(_gamepad)
    {
        //If we're on a specific OS, don't remap anything
        if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_xboxone))
        {
            description = gamepad_get_description(index);
            exit;
        }
        
        if (((vendor == "0079") && (product == "0006"))
        ||  ((vendor == "11ff") && (product == "3331")))
        {
            __input_trace("Warning! Gamepad GUID is for a chipset that's used in countless different controllers. There are too many possible remappings. Please remap manually using external software");
            
            description = gamepad_get_description(index);
            blacklisted = true;
            
            exit;
        }
        
        if (os_type == os_linux)
        {
            //Taken from https://github.com/denilsonsa/udev-joystick-blacklist/blob/master/generate_rules.py
            switch(vendor + product)
            {
                //Microsoft Microsoft Wireless Optical Desktop® 2.10
                //Microsoft Wireless Desktop - Comfort Edition
                case "045e009d":
                    
                //Microsoft Microsoft® Digital Media Pro Keyboard
                //Microsoft Corp. Digital Media Pro Keyboard
                case "045e00b0":
                    
                //Microsoft Microsoft® Digital Media Keyboard
                //Microsoft Corp. Digital Media Keyboard 1.0A
                case "045e00b4":
                    
                //Microsoft Microsoft® Digital Media Keyboard 3000
                case "045e0730":
                    
                //Microsoft Microsoft® 2.4GHz Transceiver v6.0
                //Microsoft Microsoft® 2.4GHz Transceiver v8.0
                //Microsoft Corp. Nano Transceiver v1.0 for Bluetooth
                //Microsoft Wireless Mobile Mouse 1000
                //Microsoft Wireless Desktop 3000
                case "045e0745":
                    
                //Microsoft® SideWinder(TM) 2.4GHz Transceiver
                case "045e0748":
                    
                //Microsoft Corp. Wired Keyboard 600
                case "045e0750":
                    
                //Microsoft Corp. Sidewinder X4 keyboard
                case "045e0768":
                    
                //Microsoft Corp. Arc Touch Mouse Transceiver
                case "045e0773":
                    
                //Microsoft® 2.4GHz Transceiver v9.0
                //Microsoft® Nano Transceiver v2.1
                //Microsoft Sculpt Ergonomic Keyboard (5KV-00001)
                case "045e07a5":
                    
                //Microsoft® Nano Transceiver v1.0
                //Microsoft Wireless Keyboard 800
                case "045e07b2":
                    
                //Microsoft® Nano Transceiver v2.0
                case "045e0800":
                case "046dc30a": //Logitech, Inc. iTouch Composite keboard
                case "04d9a0df": //Tek Syndicate Mouse (E-Signal USB Gaming Mouse)
                    
                //List of Wacom devices at: http://linuxwacom.sourceforge.net/wiki/index.php/Device_IDs
                case "056a0010": //Wacom ET-0405 Graphire
                case "056a0011": //Wacom ET-0405A Graphire2 (4x5)
                case "056a0012": //Wacom ET-0507A Graphire2 (5x7)
                case "056a0013": //Wacom CTE-430 Graphire3 (4x5)
                case "056a0014": //Wacom CTE-630 Graphire3 (6x8)
                case "056a0015": //Wacom CTE-440 Graphire4 (4x5)
                case "056a0016": //Wacom CTE-640 Graphire4 (6x8)
                case "056a0017": //Wacom CTE-450 Bamboo Fun (4x5)
                case "056a0018": //Wacom CTE-650 Bamboo Fun 6x8
                case "056a0019": //Wacom CTE-631 Bamboo One
                case "056a00d1": //Wacom Bamboo Pen and Touch CTH-460
                case "056a030e": //Wacom Intuos Pen (S) CTL-480
                    
                case "09da054f": //A4 Tech Co., G7 750 mouse
                case "09da1410": //A4 Tech Co., Ltd Bloody AL9 mouse
                case "09da3043": //A4 Tech Co., Ltd Bloody R8A Gaming Mouse
                case "09da31b5": //A4 Tech Co., Ltd Bloody TL80 Terminator Laser Gaming Mouse
                case "09da3997": //A4 Tech Co., Ltd Bloody RT7 Terminator Wireless
                case "09da3f8b": //A4 Tech Co., Ltd Bloody V8 mouse
                case "09da51f4": //Modecom MC-5006 Keyboard
                case "09da5589": //A4 Tech Co., Ltd Terminator TL9 Laser Gaming Mouse
                case "09da7b22": //A4 Tech Co., Ltd Bloody V5
                case "09da7f2d": //A4 Tech Co., Ltd Bloody R3 mouse
                case "09da8090": //A4 Tech Co., Ltd X-718BK Oscar Optical Gaming Mouse
                case "09da9033": //A4 Tech Co., X7 X-705K
                case "09da9066": //A4 Tech Co., Sharkoon Fireglider Optical
                case "09da9090": //A4 Tech Co., Ltd XL-730K / XL-750BK / XL-755BK Laser Mouse
                case "09da90c0": //A4 Tech Co., Ltd X7 G800V keyboard
                case "09daf012": //A4 Tech Co., Ltd Bloody V7 mouse
                case "09daf32a": //A4 Tech Co., Ltd Bloody B540 keyboard
                case "09daf613": //A4 Tech Co., Ltd Bloody V2 mouse
                case "09daf624": //A4 Tech Co., Ltd Bloody B120 Keyboard
                    
                //Corsair Harpoon RGB gaming mouse
                case "1b1c1b3c":
                    
                //[T3] 2.4GHz and IR Air Mouse Remote Control
                case "1d57ad03":
                    
                //Roccat Tyon Mouse
                case "1e7d2e4a":
                    
                //Winkeyless.kr Keyboards
                case "20a0422d":
                    
                //Cooler Master Storm Mizar Mouse
                case "2516001f":
                    
                //Cooler Master Storm Alcor Mouse
                case "25160028":
                    blacklisted = true;
                break;
            }
        }
            
        //Created under advice from offalynne
        if (os_type == os_android)
        {
            var _description_lower = string_lower(gamepad_get_description(index));
            var _array = ["mouse",       "trackball",  "keyboard",    "button jack",
                            "headphones",  "jabra",      "transceiver", "surface type",
                            "touchscreen", "multitouch", "headset",     "sennheiser",
                            "corsair"];
                
            var _i = 0;
            repeat(array_length(_array))
            {
                if (string_pos(_array[_i], _description_lower) > 0)
                {
                    blacklisted = true;
                    break;
                }
                    
                ++_i;
            }
        }
            
        //Created under advice from offalynne
        switch(guid)
        {
            case "7e050e20000000000000504944564944": // joycon charger windows
            case "030000007e0500000e20000000020000": // joycon charger macos
            case "030000007e0500000e20000011010000": // joycon charger linux
            case "65366131663736363061313736656431": // joycon charger android
            case "030000007e0500000920000000020000": // pro controller macos
            case "030000007e0500000920000011010000": // pro controller linux
            case "61393962646434393836356631636132": // pro controller android
            case "61373939383333653939323337373730": // ps/2 usb adapter android
            case "35623363656536396133623234666231": // elecom trackball android
            case "32646532373735653736353036656333": // 8bd psc adapter android
            case "64623037323132643231333433383536": // audio headset android
            case "4c056802000000000000504944564944": // ps3 windows (bad format, sans sony driver)
                
            // bad switch format on windows (wired), sans steam
            case "7e050920000000000000504944564944": // pro controller 
            case "7e051720000000000000504944564944": // snes online
                blacklisted = true;
            break;
        }
            
        if (blacklisted)
        {
            __input_trace("Warning! Device is some sort of weirdo thing that we have access to for some reason");
            description = gamepad_get_description(index);
            
            exit;
        }
        
        if (xinput)
        {
            description = "XInput";
            exit;
        }
        
        if ((os_type == os_macosx) && ((gamepad_get_mapping(index) == "") || (gamepad_get_mapping(index) == "no mapping")))
        {
            __input_trace("Warning! Gamepad already has a native GameMaker remapping");
            description = gamepad_get_description(index);
            exit;
        }
        
        if (!INPUT_SDL2_REMAPPING)
        {
            __input_trace("Skipping SDL2 remapping");
            description = gamepad_get_description(index);
            exit;
        }
        
        //TODO - Use structs instead?
        var _vp_array = variable_struct_get(global.__input_sdl2_database.by_vendor_product, vendor + product);
        var _os_array = variable_struct_get(global.__input_sdl2_database.by_platform, os_type);
                
        var _result_array = [];
                
        var _v = 0;
        repeat(array_length(_vp_array))
        {
            var _definition = _vp_array[_v];
                
            var _o = 0;
            repeat(array_length(_os_array))
            {
                if (_os_array[_o] == _definition)
                {
                    _result_array[@ array_length(_result_array)] = _definition;
                    break;
                }
                        
                ++_o;
            }
                    
            ++_v;
        }
                
        var _definition = undefined;
        if (array_length(_result_array) > 0) //Get the first binding for this vendor+product and OS
        {
            var _definition = _result_array[0];
        }
        else if (array_length(_vp_array) > 0) //If that fails, try using the binding for this gamepad from any OS
        {
            var _definition = _vp_array[0];
        }
                
        if (is_array(_definition))
        {
            sdl2_definition = _definition;
            description = _definition[1];
        }
        else
        {
            __input_trace("Warning! No SDL defintion found for vendor=", vendor, ", product=", product);
            description = "Unknown";
        }
    }
}