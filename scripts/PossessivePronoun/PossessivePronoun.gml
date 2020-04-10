/// @func PossessivePronoun(root)
/// @desc returns his or her based on sex of root
/// @arg root (id) the root human
var root = argument0;

switch(root.sex)
{
	case "female":
		return "her";
		break;
	case "male":
		return "his";
		break;
}