function input_virtual_debug_draw()
{
    var _i = 0;
    repeat(array_length(global.__input_virtual_array))
    {
        global.__input_virtual_array[_i].ref.__debug_draw();
        ++_i;
    }
}