/// @func ReflectRelation(relation)
/// @desc returns a relation (string) that has been reflected from the calling instance's id
/// @arg relation (string) the string to reflect
var relation = argument0;
var match = 0;
var index = 0;

switch(relation)
{
	case "child":
		return "parent";
		break;
	case "parent":
		return "child";
		break;
	case "grandchild":
		return "grandparent";
		break;
	case "grandparent":
		return "grandchild";
		break;
	case "pibling":
		return "nibling";
		break;
	case "nibling":
		return "pibling";
		break;
	default:
		return relation; // for sibling and piblings
}