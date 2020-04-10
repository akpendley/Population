/// @func ListToArray(ds_list)
/// @desc Accepts a list and returns an array
/// @arg ds_list (list) to be converted
var list = argument0;
var a = array_create(ds_list_size(list), 0);

for (var i = 0; i < ds_list_size(list); i++)
{
	a[i] = list[| i];
}

return a;