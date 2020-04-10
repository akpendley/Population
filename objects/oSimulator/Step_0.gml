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

	if (instance_number(oHuman) == 0)
	{
		Log("All humans have perished. Everything is still.");
		game_end();
	}
	else
	{
		LogCensus();
		// output all relation data of heads of household
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
		// we're done with the simulation, shut down (this will change)
		game_end();
	}
}