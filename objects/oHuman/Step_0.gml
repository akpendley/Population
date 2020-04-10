/// @description life
// basic movement to head of household
if (headOfHousehold != id && instance_exists(headOfHousehold) && !dragging)
{
	x += ((headOfHousehold.x + lengthdir_x(offsetLength, offsetDirection)) - x) * 0.2;
	y += ((headOfHousehold.y + lengthdir_y(offsetLength, offsetDirection)) - y) * 0.2;	
}
if (dragging)
{
	x += (mouse_x - x) * 0.2;
	y += (mouse_y - y) * 0.2;	
}
		
if (global.simulating)
{
	age++;
	// increase age by a year
	
	if (age > ageToChangeFace)
	{
		sprite_index = GetAgedFace(face, age);
	}
	
	// movement
	if (global.player == id)
	{
		// check for movement inputs
		var facing = -1;
		if (keyboard_check(ord("D")))
		{
			facing = 0;
		}
		if (keyboard_check(ord("W")))
		{
			facing = 90;
		}
		if (keyboard_check(ord("A")))
		{
			facing = 180;
		}
		if (keyboard_check(ord("S")))
		{
			facing = 270;
		}
		
		if (facing != -1)
		{
			// calculate
			var ms = moveSpeeds[moveSpeed];
			var x_pos = x + lengthdir_x(ms, facing);
			var y_pos = y + lengthdir_y(ms, facing);
		
			// move player
			if (place_free(x_pos, y_pos))
			{
				x = x_pos;
				y = y_pos;
			}
		}
	}
	else
	{
		
		
		if (sex == "female" && age >= 16)
		{
			// MARRIAGE
			// see if we want to get married if single
			if (FindRelative(id, "spouse") == noone)
			{
				// find a spouse
				TryToMarry();

			}
	
			// BIRTH
			var birthOdds = CheckBirthOdds(age);
			// check odds of giving birth
	
			if (irandom_range(0, 100) < birthOdds * 3)
			{
				if (instance_exists(FindRelative(id, "spouse")))
				{
					// husband is alive, so give birth
					GiveBirth();
				}
			}
		}


		// INCREASE CORE STAT
		if (irandom_range(1, 10) == 1)
		{
			var choice = irandom_range(0, 5);
			coreStats[choice] = clamp(coreStats[choice] + 1, 1, 20);	
			if (coreStats[choice] % 5 == 0)
			{
				Log(name + " increased " + PossessivePronoun(id) + " understanding of " + global.coreStatsNames[choice] + " to level " + string(coreStats[choice]) + ".");
			}
		}
	
		if (mourning && irandom_range(1, 1) == 1)
		{
			mourning = false;
		}
	}
}