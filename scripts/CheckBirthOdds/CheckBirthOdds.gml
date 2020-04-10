/// @func CheckBirthOdds(age)
/// @desc returns a whole number, rounded up, from the data array
/// @age (number) the age of the root human

var age = argument0;

for (var i = 0; i < array_length_1d(global.birthRates); i++)
{
	var bR = global.birthRates[i];
	
	if (age <= bR[0])
	{
		return ceil(bR[1]);
	}
}

return 0;