/// @func LogCensus()
/// @desc logs debug messages for all of the human's relatives, debug only

Log("");
Log("--------------- Census -----------------");
var humans = ds_list_create();
//var loggedHumans = ds_list_create();

// find the heads of households
for (var i = 0; i < instance_number(oHuman); i++)
{
	var h = instance_find(oHuman, i);
	if (h.headOfHousehold == h)
	{
		// this is a head of household, list all of their relatives
		var text = "";
		var numDependents = 1;
	
		// list all relatives	
		for (var j = 0; j < instance_number(oHuman); j++)
		{
			var r = instance_find(oHuman, j);

			if (r.headOfHousehold == h && r != h)
			{
				
				if (string_count(", dec.", FindRelation(h, r)) == 0)
				{
					text += "    (" + string(Genderfy([r, FindRelation(h, r)])) + ") " + r.name;
					text += " (" + string(r.age) + ")";
				}
				if (text != "")
				{
					text += "\n";
					numDependents++;
					//ds_list_add(loggedHumans, r); // debug
				}
			}
		}
		
		if (numDependents < 2)
		{
			text = h.name + " (" + string(h.age) + "), single." + text;
		}
		else
		{
			text = h.name + "'s (" + string(h.age) + ") family of " + string(numDependents) + " :\n" + text;
		}
		
		Log(text);
		Log("-------------------------------------------");
	}
}