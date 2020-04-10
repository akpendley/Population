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

/*
// which axis is it in?
for (var i = 0; i < array_length_1d(global.familySelfAxis); i++)
{
	if (relation == global.familySelfAxis[i])
	{
		// it's a parent/child
		match = 1;
		index = i - 2;
		break;
	}
}

for (var i = 0; i < array_length_1d(global.familySiblingAxis); i++)
{
	if (relation == global.familySiblingAxis[i])
	{
		// it's a sibling/parent's sibling
		match = 2;
		index = i - 2;
		break;
	}
}

for (var i = 0; i < array_length_1d(global.familyNiblingAxis); i++)
{
	if (relation == global.familyNiblingAxis[i])
	{
		match = 3;
		index = i - 2;
		break;
	}
}

Log(match);

switch(match)
{
	case 1: // self axis
		// index refers to the distance from self on the array
		if (index != 0)
		{
			// return the reflected index across element 2 (self)
			return global.familySelfAxis[2 + index * -1];
		}
		break;
		
	case 2: // sibling axis
		// index refers to the distance from self on the array
		if (index != 0)
		{
			// return the reflected index across element 2 (self)
			return global.familySiblingAxis[2 + index * -1];
		}
		break;
		
	case 3: // nibling axis
		// index refers to the distance from self on the array
		if (index != 0)
		{
			// return the reflected index across element 2 (self)
			return global.familyNiblingAxis[2 + index * -1];
		}
		break;
	default:
		return "kin";
}
