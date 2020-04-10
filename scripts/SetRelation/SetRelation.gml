/// @func SetRelation(root, relative, relation)
/// @desc change the relation of the relative and set it to the new relation provided
/// @arg root (id) the root human
/// @arg relative (id) whose relation to change with respect to the root
/// @arg relation (string) new relation to set

var root = argument0;
var relative = argument1;
var relation = argument2;

for (var i = 0; i < ds_list_size(root.relatives); i++)
{
	var r = root.relatives[| i];
	if (r[0] == relative)
	{
		r[1] = relation;
		ds_list_set(root.relatives, i, r);
	}
}