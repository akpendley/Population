/// @func FindRelative(root, relative)
/// @desc returns a relation (string) from the root's relatives list with the provided relative (id), if it exists otherwise, "none"
/// @arg root (id) the base ancestor
/// @arg relative (id) the human whose relation we need to find 

var root = argument0;
var relative = argument1;

for (var i = 0; i < ds_list_size(root.relatives); i++)
{
	var r = root.relatives[| i];
	if r[0] == relative
	{
		return r[1];
	}
}

return "none";
// if we looped through the whole relatives list and didn't find anyone, return none