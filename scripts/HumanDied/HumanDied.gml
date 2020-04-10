/// @func HumanDied(root)
/// @desc change the root's relatives' relations to reflect the root's death
/// @arg root (id) the root human

var root = argument0;

// obituary

var obituary = root.name + " died at age " + string(root.age) + " of " + root.deathCase;

var rel = FindRelative(root, "spouse");

if (rel != noone && instance_exists(rel))
{
	obituary += ", widowing " + rel.name + ".";
}
else
{
	obituary += ".";
}

var family = ds_list_create();
if (root.headOfHousehold == root)
{
	// transfer headOfHousehold to wife or children
	
	for (var i = 0; i < instance_number(oHuman); i++)
	{
		var h = instance_find(oHuman, i);
		
		if (h.headOfHousehold == root && h != root)
		{
			ds_list_add(family, h);
		}
	}


	var topAge = 0;
	var newHOH = noone;
	// find the family member with the top matching age
	for (var i = 0; i < ds_list_size(family); i++)
	{
		var h = family[| i];
		if (h.age > topAge)
		{
			newHOH = h;
			topAge = h.age;
		}
	}

	if (newHOH == noone && ds_list_size(family) > 0)
	{
		Log("Why are you the way you are?");
	}
	
	if (newHOH != noone)
	{
		// set the new head of household for the family
		for (var i = 0; i < ds_list_size(family); i++)
		{
			var h = family[| i];
			h.headOfHousehold = newHOH;
			// Log(h.name + "'s new HoH is " + newHOH.name + "."); // debug
		}
	}
	
	if (ds_list_size(family) > 1)
	{
		obituary += "\n" + root.firstName + " leaves behind a family of " + string(ds_list_size(family)) + ". ";
			
	}
		
	if (ds_list_size(family) > 0)
	{
		obituary += "\n" + root.firstName + "'s " + Genderfy([newHOH, FindRelation(root, newHOH)]) + ", " + newHOH.name + ", takes up the head of house " + root.lastName + ".";
	}
		
	if (ds_list_size(family) <= 0)
	{
		var near = 0;
		for (var j = 0; j < ds_list_size(root.relatives); j++)
		{
			var _r = root.relatives[| j];
			if (instance_exists(_r[0]))
			{
				near++;
			}
		}
			
		var far = 0;
		for (var j = 0; j < instance_number(oHuman); j++)
		{
			var _r = instance_find(oHuman, j);
			// get a list of every human and see if they have any relation to me
			if (FindRelation(_r, id) != "none")
			{
				far++;
			}
		}
		
		if (near > 0 || far > 0)
		{
			
			obituary += "\n" + root.firstName + " leaves behind an empty home, but a legacy among the town and distant relatives.";
		}
		else
		{
			// no descendents
			if (root.birthTown == oSimulator.townName)
			{
				if (root.age >= 45)
				{
					obituary += "\n" + root.firstName + " was the last connection to a vast history of this town.\nWith " + PossessivePronoun(root) + " passing, we celebrate the achievement of a life lived.";
				}
				else
				{
					obituary += "\n" + root.firstName + " lived their life well here in " + oSimulator.townName + ", " + Pronoun(root) + " will be missed.";
				}
			}
			else
			{
				obituary += "\nThough " + Pronoun(root) + " was from another township, " + root.firstName + " will be missed.";
			}
		}
	}
}

Log(obituary);

// set relations to deceased

for (var i = 0; i < ds_list_size(root.relatives); i++)
{
	var r = root.relatives[| i];
	r = r[0];
	if (instance_exists(r))
	{
		// find me in their relatives list and add " - deceased" to my relation
		r = r.relatives;
		for (var j = 0; j < ds_list_size(r); j++)
		{
			var rr = r[| j];
			if (rr[0] == root)
			{
				var rel = rr[1];
				//Log(rr[1]);
				//Log(rel);
				rel += ", dec.";
				rr[1] = rel;
				ds_list_set(r, j, rr);
			}
		}
	}
}

ds_list_destroy(family);
ds_list_destroy(root.relatives);