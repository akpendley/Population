/// @func RandomName( bFirst, strSex )
/// @desc Returns a random first (true) or last (false) name
/// @arg bFirst first name (true) last name (false)
/// @arg strSex female or male

var b = argument0;
// true = first name, false = last name

var sex = argument1;
// "female" or "male"

if (b)
{
	// first name
	if (sex == "female")
	{
		return oSimulator.femaleFirstNames[| irandom_range(0, ds_list_size(oSimulator.femaleFirstNames) - 1)]; 
		// random female first name
	}
	else
	{
		return oSimulator.maleFirstNames[| irandom_range(0, ds_list_size(oSimulator.maleFirstNames) - 1)];
		// random male first name
	}
}
else
{
	return oSimulator.lastNames[| irandom_range(0, ds_list_size(oSimulator.lastNames) - 1)];
	// random last name
}