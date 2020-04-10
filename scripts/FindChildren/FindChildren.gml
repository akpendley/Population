/// @func FindRelative(root, bIncludeStepChildren)
/// @desc returns a relative (array) from the root's relatives list with the provided relation (string), if it exists, otherwise noone
/// @arg root (id) the base ancestor
/// @arg bIncludeStepChildren (boolean) 

var root = argument0;
var bIncludeStepChildren = argument1;
var relation = "child";
var list = ds_list_create();

for (var i = 0; i < ds_list_size(root.relatives); i++)
{
	var r = root.relatives[| i];
	if (bIncludeStepChildren)
	{
		if (string_count(relation, r[1]) > 0)
		{
			ds_list_add(list, r[0]);
		}
	}
	else
	{
		if r[1] == relation
		{
			ds_list_add(list,r[0]);
		}
	}
}

var array = array_create(ds_list_size(list), 0);
for(var i = 0; i < ds_list_size(list); i++)
{
	array[i] = list[| i];
}

return array;
// return the array