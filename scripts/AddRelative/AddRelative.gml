/// @func AddRelatives(root, relative, relation)
/// @desc add the relative with id and relation to the list
/// @arg root (id) the base human
/// @arg relative (id) the relative we're adding to the base
/// @arg relation (string) "mother", "husband", etc.

var root = argument0;
var relative = argument1;
var relation = argument2;

var array = [relative, relation, relative.firstName, relative.lastName, relative.name, relative.birthTown];
ds_list_add(root.relatives, array);