/// @func RemoveRelative(originID, relation)
/// @desc remove a relative from the base human's list
/// @arg originID (id) base human
/// @arg relation (string) ex. "mother", "husband"

var originID = argument0;
var relation = argument1;
var list = originID.relatives;

for(var i = 0; i < ds_list_size(list) - 1; i++)
{
	var r = list[| i];
	
	if (r[1] == relation)
	{
		ds_list_delete(list, i);
		break;
	}
}