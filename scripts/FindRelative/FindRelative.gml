/// @func FindRelative(root, relation)
/// @desc returns a relative (id) from the root's relatives list with the provided relation (string), if it exists, otherwise noone
/// @arg root (id) the base ancestor
/// @arg relation (string) string 

var root = argument0;
var relation = argument1;

for (var i = 0; i < ds_list_size(root.relatives); i++)
{
	var r = root.relatives[| i];
	if r[1] == relation
	{
		return r[0];
	}
}

return noone;
// if we looped through the whole relatives list and didn't find anyone, return noone