/// @func RollMultipleBirth()
/// @desc return a number of humans to spawn during child birth

var num = 1;

if (irandom_range(1, 60) == 1)
{
	Log("Twins!");
	num = 2;
}

if (irandom_range(1, 1000) == 1)
{
	Log("Triplets!");
	num = 3;
}

if (irandom_range(1, 10000) == 1)
{
	Log("Quadruplets!");
	num = 4;
}

if (irandom_range(1, 55000000) == 1)
{
	Log("Quintuplets!");
	num = 5;
}

return num;