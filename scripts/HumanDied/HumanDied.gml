/// @func HumanDied(root)
/// @desc change the root's relatives' relations to reflect the root's death
/// @arg root (id) the root human

var root = argument0;

// obituary

var obituary = root.name + " died at age " + string(root.age) + " of " + root.deathCase;
// "John smith died at age 28 of syphilis"

var rel = FindRelative(root, "spouse");
// id of the spouse

if (rel != noone && instance_exists(rel))
{
	// if there is a spouse, they are widowed
	obituary += ", widowing " + rel.name + ".";
	// ", widowing Jane Smith."
}
else
{
	obituary += ".";
	// "."
	// there are more elegant ways to do this
}

var family = ds_list_create();
// new list who's this

if (root.headOfHousehold == root)
{
	// if this human was a head of household, try and pass on the responsibility
	for (var i = 0; i < instance_number(oHuman); i++)
	{
		var h = instance_find(oHuman, i);
		// find humans that have me as their head of household (be sure not to count myself)
		if (h.headOfHousehold == root && h != root)
		{
			ds_list_add(family, h);
			// add them to the list
		}
	}

	var topAge = 0;
	// (number) max age found
	
	var newHOH = noone;
	// (id) new head of household
	
	// find the family member with the top age
	for (var i = 0; i < ds_list_size(family); i++)
	{
		var h = family[| i];
		// id
		if (h.age > topAge)
		{
			// if this human's age is greater than the current max, set the new max
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
	
	// check how big the deceased's family is
	if (ds_list_size(family) > 1)
	{
		obituary += "\n" + root.firstName + " leaves behind a family of " + string(ds_list_size(family)) + ". ";
		// "John leaves behind a family of 16."
	}
		
	if (ds_list_size(family) > 0)
	{
		obituary += "\n" + root.firstName + "'s " + Genderfy([newHOH, FindRelation(root, newHOH)]) + ", " + newHOH.name + ", takes up the head of house " + root.lastName + ".";
		// "John's wife, Jane, takes up the head of house Smith."
	}
		
	if (ds_list_size(family) <= 0)
	{
		var near = 0;
		for (var j = 0; j < ds_list_size(root.relatives); j++)
		{
			var _r = root.relatives[| j];
			if (instance_exists(_r[0]))
			{
				// count how many relatives I know that are still alive
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
				// count how many humans have a relation TO ME that are alive
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
		// find me in their relatives list and add ", dec." to my relation
		r = r.relatives;
		for (var j = 0; j < ds_list_size(r); j++)
		{
			var rr = r[| j];
			if (rr[0] == root)
			{
				var rel = rr[1];
				rel += ", dec.";
				rr[1] = rel;
				ds_list_set(r, j, rr);
			}
		}
	}
}

ds_list_destroy(family);
ds_list_destroy(root.relatives);