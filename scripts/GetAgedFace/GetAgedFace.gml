/// @func GetAgedFace( face, age )
/// @desc returns a sprite from a face array with the given age
/// @arg face (string) "m#"
/// @arg age (number)
var f = argument0;
var a = argument1;

// set sprite
var sprites = global.faces[? f];
var index = 0;

if (a >= 4 && a < 15)
{
	index = 1;
}

if (a >= 15 && a < 25)
{
	index = 2;
}

if (a >= 25 && a < 40)
{
	index = 3;
}

if (a >= 40 && a < 65)
{
	index = 4;
}

if (a >= 65)
{
	index = 5;
}

return sprites[index];