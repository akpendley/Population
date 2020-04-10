/// @func GetRandomTownName()
/// @desc returns a random string town name, other than the simulator town name if one is set

var name = oSimulator.townName;
var newName = name;

while(newName == name)
{
	newName = oSimulator.townNames[| irandom_range(0, ds_list_size(oSimulator.townNames) - 1)];
}

return newName;