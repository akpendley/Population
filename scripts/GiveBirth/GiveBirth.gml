/// @func GiveBirth()
/// @desc checks for childbirth death scenarios and multiple births, then spawns humans

if (!mourning)
{
	if (irandom_range(1, 250) == 1)
	{
		// unlucky, complications ahead
		var issue = irandom_range(1, 4);
		switch(issue)
		{
			case 1:
				// birth complications, both die
				Log(name + " had birth complications and passed with her baby during birth.");
				deathCase = "birth complications";
				instance_destroy();
				break;
			case 2:
				// high blood pressure, mother dies
				Log(name + " gave birth, but " + firstName + "'s heart failed and she passed.");
				SpawnHuman("birth", RollMultipleBirth());
				deathCase = "high blood pressure";
				instance_destroy();
				break;
			case 3:
				// infection, mother dies next year
				Log(name + " gave birth, but " + firstName + " is frail with infection.");
				infection = true;
				SpawnHuman("birth", RollMultipleBirth());
				break;
			case 4:
				// infection, baby dies
				Log(name + " gave birth but the child passed with infection.");
				break;
		}
	}
	else
	{
		// normal birth
		SpawnHuman("birth", RollMultipleBirth());
	}
}
else
{
	mourning = false;
	Log(name + " has recovered from mourning.");
}