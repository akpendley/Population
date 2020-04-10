/// @func GetAgedFace( face, age )
/// @desc returns a sprite from a face array with the given age
/// @arg face (string) "m#"
/// @arg age (number)
var f = argument0; // the face string is composed of the first letter of the human's sex (f or m) and a number
var a = argument1;

// set sprite
var sprites = global.faces[? f];
var index = 0;
// baby


if (a >= 4 && a < 15)
{
	index = 1;
	// kid
}

if (a >= 15 && a < 25)
{
	index = 2;
	// young adult
}

if (a >= 25 && a < 40)
{
	index = 3;
	// adult
}

if (a >= 40 && a < 65)
{
	index = 4;
	// mature adult
}

if (a >= 65)
{
	index = 5;
	// senior
}

return sprites[index];