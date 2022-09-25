input_tick();

if (input_keyboard_check_pressed(vk_escape) || input_gamepad_check_pressed(input_player_get_gamepad(), gp_start))
{
    input_binding_scan_abort();
}

if (!input_binding_scan_in_progress())
{
    //Ignore A + B + C
    if (input_keyboard_check_pressed(ord("I")))
    {
        rebinding_source = input_source_get_array();
        
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source,
        0,
        ["A", "B", "C"]);
    }
    
    //Allow A + B + C
    if (input_keyboard_check_pressed(ord("A")))
    {
        rebinding_source = input_source_get_array();
        
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source,
        0,
        undefined,
        ["A", "B", "C"]);
    }
    
    //Ignore A + B, but allow A + B + C
    //Since ignore > allow, this means only C is valid
    if (input_keyboard_check_pressed(ord("M")))
    {
        rebinding_source = input_source_get_array();
        
        input_binding_scan_start(function(_new_binding)
        {
            input_binding_set_safe("up", _new_binding);
        },
        undefined,
        rebinding_source,
        0,
        ["A", "B"],
        ["A", "B", "C"]);
    }
}