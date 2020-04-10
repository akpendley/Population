/// @func Pronoun(root)
/// @desc returns he or she based on sex of root
/// @arg root (id) the root human
var root = argument0;

switch(root.sex)
{
	case "female":
		return "she";
		break;
	case "male":
		return "he";
		break;
}