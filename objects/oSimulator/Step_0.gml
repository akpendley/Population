/// @description update simulation


if (global.simulating)
{
	ResetLog();
	Log("-------------------------------------------");
	Log("");
	Log("");
	Log("***************************");
	Log("********** YEAR " + string(global.year) + " **********");
	Log("----- " + townName + ", population " + string(instance_number(oHuman)) + " -----");
	Log("***************************");
	Log("");

	var humans = ds_list_create();

	if (instance_number(oHuman) == 0)
	{
		Log("All humans have perished. Everything is still.");
		game_end();
	}
	else
	{
		LogCensus();
	}

	Log("--------------- Events -----------------");
	Log("");

	global.year++;

	if (irandom_range(1, 4) == 1)
	{
		// spawn random human to add to gene pool
		SpawnHuman("random", 1);
	}

	if (global.year >= simulationEndYear)
	{
		game_end();
	}
}