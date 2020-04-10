/// @func CheckDeathOdds(age)
/// @desc kills you 1000 different ways
/// @arg age (number) age is just a number

var age = argument0;
for(var i = 0; i < array_length_1d(global.deathRates); i++)
{
	var dR = global.deathRates[i];
	if (age <= dR[0])
	{
		var oddsMap = dR[1];
		// don't look
		for(var j = 0; j < array_length_1d(global.causesOfDeath); j++)
		{
			// get the chance, name, and deathCase
			var chance = oddsMap[? global.causesOfDeath[j]];
			
			if (irandom_range(1, 1000) <= chance)
			{
				// we got it
				deathCase = global.causesOfDeath[j];
				instance_destroy();
				return;
			}
		}
		// we didn't die at this Death Rate Table, so break out of the loop because we don't
		// want to recalculate odds at higher ages for this human
		break;
	}
}

if (infection)
{
	if (irandom_range(1, 5) != 1)
	{
		infection = false;
		Log(name + " recovered from infection, and is healthy.");
	}
	else
	{
		Log(name + " fought the infection hard, but has passed.");
		deathCase = "infection";
		instance_destroy();
		return;
	}
}