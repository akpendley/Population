/// @func FindRelative(root, relation)
/// @desc returns a relative (id) from the root's relatives list with the provided relation (string), if it exists, otherwise noone
/// @arg root (id) the base ancestor
/// @arg relation (string) string 

var root = argument0;
// id

var relation = argument1;
// string

for (var i = 0; i < ds_list_size(root.relatives); i++)
{
	// loop through the relatives list of the root
	var r = root.relatives[| i];
	// array, see "oHuman - Create"
	
	if r[1] == relation
	{
		// found a match return the id
		return r[0];
	}
}

return noone;
// if we looped through the whole relatives list and didn't find anyone, return noone