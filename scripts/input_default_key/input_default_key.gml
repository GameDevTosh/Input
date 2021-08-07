/// @param key
/// @param verb
/// @param [alternate]

function input_default_key(_key, _verb, _alternate = 0)
{
    if (__INPUT_DEBUG) __input_trace("Setting default keyboard binding...");
    
    //Never allow keyboard bindings on console
    if ((!__INPUT_ON_CONSOLE) && ((!__INPUT_ON_MOBILE) || INPUT_MOBILE_KEYBOARD_ALLOWED)) global.__input_keyboard_valid = true;
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_key(_key);
    
    global.__input_default_player.set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate, _binding);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
        var _binding = new __input_class_binding();
        _binding.set_key(_key);
        
        global.__input_players[_p].set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate, _binding);
        
        ++_p;
    }
}