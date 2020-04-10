/// @func TryToMarry()
/// @desc look for a viable spouse, if you're up to it

if (irandom_range(1, 3) == 1)
{
	if (!mourning)
	{
		for (var i = 0; i < instance_number(oHuman); i++;)
		{
		
			var human = instance_find(oHuman, i);
			// out of all humans
			
			if ( human.lastName != lastName // not my last name, so can't be me or any direct relatives
				&& FindRelation(human, id) == "none" // i'm not their relative
				&& FindRelation(id, human) == "none" // he's not my relative
				&& FindRelative(human, "spouse") == noone // he's single
				&& human.sex == "male" // he's a he
				&& human.age >= 16 // he's legal
				&& abs(human.age - age) < 15 // we're close in age
				)
			{
				Log(name + " & " + human.name + " got married.");
					
				lastName = human.lastName;
				// set wife's last name
					
				name = firstName + " " + lastName;
				// reset wife's full name
					
				AddRelative(human, id, "spouse");
				// set her to my spouse
					
				AddRelative(id, human, "spouse");
				// set her spouse to me
			
				if (headOfHousehold == id)
				{
					// I was a head of household, I might have children
					for (var j = 0; j < instance_number(oHuman); j++)
					{
						// find everyone that has me as their head of household
						var h = instance_find(oHuman, j);
						if (h.headOfHousehold == id && h != id)
						{
							// and change it to my husband
							h.headOfHousehold = human;
						
							// add the husband as a step-parent to each child or step-child
							if (FindRelation(id, h) == "child" || FindRelation(id, h) == "step-child")
							{
								AddRelative(h, human, "step-parent");
								AddRelative(human, h, "step-child");
							}
							// Log(h.name + "'s new HoH is " + human.name); // debug
						}
					}
				}
			
				if (human.headOfHousehold == human)
				{
					// He was a head of household, he might have children
					for (var j = 0; j < instance_number(oHuman); j++)
					{
						// find everyone that has him as their head of household
						var h = instance_find(oHuman, j);
						if (h.headOfHousehold == human && h != human)
						{
							// add the wife as a step-parent to each child or step-child
							if (FindRelation(id, h) == "child" || FindRelation(id, h) == "step-child")
							{
								AddRelative(h, id, "step-parent");
								AddRelative(id, h, "step-child");
							}
						}
					}
				}
			
				headOfHousehold = human;
				// set him as my head of household
			
				human.headOfHousehold = human;
				// set him as his head of household
			
				// gather a list of all children
				var children = FindChildren(human, true);
			
				// double loop to reflect all children's relations (step-sibling or sibling)
				for (var j = 0; j < array_length_1d(children); j++)
				{
					var child = children[j];
					for (var k = 0; k < array_length_1d(children); k++)
					{
						var rel = children[k];
						if (instance_exists(rel) && instance_exists(child) && FindRelation(child, rel) == "none")
						{
							// if the kids don't have a relation, they're step-sibling
							AddRelative(child, rel, "step-sibling");
							AddRelative(rel, child, "step-sibling");
						}
					}
				}
			
				break;
			}	
		}
	}
	else
	{
		mourning = false;
		Log(name + " has recovered from mourning.");
	}
}