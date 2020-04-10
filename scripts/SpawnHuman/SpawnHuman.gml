/// @func SpawnHuman( birthCase, num )
/// @desc spawns a number of humans with birth case
/// @arg birthCase "random" or "birth"
/// @arg num humans to spawn

var b = argument0;
// birth case, random or birth

var num = argument1;
// number of humans to spawn

repeat(num)
{
	var inst = instance_create_depth(0, 0, 0, oHuman);
	// create our invisible human object	
	
	switch(b)
	{
		case "random":
			inst.birthTown = GetRandomTownName();
			
			var femaleSurplus = 0;
			for(var i = 0; i < instance_number(oHuman); i++)
			{
				var human = instance_find(oHuman, i);
				if (human != id)
				{
					if (human.sex == "female")
					{
						femaleSurplus++;
					}
					else
					{
						femaleSurplus--;
					}
				}
			}
			
			if (femaleSurplus >= 0)
			{
				inst.sex = "male";
			}
			else
			{
				inst.sex = "female";
			}
			inst.sex = choose("female", "male");
			
			inst.face = string_copy(inst.sex, 0, 1) + string(0);
			
			inst.firstName = RandomName(true, inst.sex);
			inst.lastName = RandomName(false, inst.sex);
			inst.name = inst.firstName + " " + inst.lastName;
			inst.age = irandom_range(16, 40);
			inst.headOfHousehold = inst;
			Log(inst.name + ", " + inst.sex + ", (" + string(inst.age) + ") has arrived from " + inst.birthTown + " to start a new life.");
			break;
		case "birth":
			// set the new child's birth town to this town
			inst.birthTown = oSimulator.townName;
			
			inst.sex = choose("female", "male");
			inst.face = string_copy(inst.sex, 0, 1) + string(0);
			inst.firstName = RandomName(true, inst.sex);
			
			var mother = id; // this code is always called from a mother with the birthCase
			var father = FindRelative(id, "spouse");
			
			// set the child's last name
			inst.lastName = father.lastName;
			inst.name = inst.firstName + " " + inst.lastName;
			Log(inst.name + " was born to " + string(firstName + " and " + father.name + "."));
			
			//Log(mother.name + "'s relatives:\n" + string(mother.relatives));
			//Log(father.name + "'s relatives:\n" + string(father.relatives));
			
			// add mother and father relatives
			var newRelatives = ds_list_create();
			ds_list_copy(newRelatives, mother.relatives);
			for (var i = 0; i < ds_list_size(father.relatives); i++)
			{
				var h = father.relatives[| i];
				ds_list_add(newRelatives, h);
			}
			
			//Log("\n\n Merged relatives list:\n" + string(ListToArray(newRelatives)));
			
			// get rid of duplicates
			for (var i = 0; i < ds_list_size(newRelatives); i++)
			{
				var h = newRelatives[| i];
				for (var j = 0; j < ds_list_size(newRelatives); j++)
				{
					var h2 = newRelatives[| j];
					if (h[0] == h2[0] && i != j)
					{
						// found duplicate
						ds_list_delete(newRelatives, j);
						j--;
					}
				}
			}
			

			// get rid of the deceased relatives
			for (var i = 0; i < ds_list_size(newRelatives); i++)
			{
				var h = newRelatives[| i];
				if (!instance_exists(h[0]))
				{
					ds_list_delete(newRelatives, i);
					i--;
				}
			}
			
			
			//Log("\n\n No duplicates or deceased:\n" + string(ListToArray(newRelatives)));
			
			// move relations up a generation
			for (var i = 0; i < ds_list_size(newRelatives); i++)
			{
				// don't move children up, they become siblings further down
				var h = newRelatives[| i];
				var relation = h[1];
				var relationPrefix = "";
				
				// preserve prefixes 
				if (string_count("step-", h[1]) > 0)
				{
					relation = string_replace_all(h[1], "step-", "");
					relationPrefix += "step-";
				}
				
				repeat(string_count("great-", h[1]))
				{
					relationPrefix += "great-";
					string_replace(h[1], "great-", "");
				}
				
				// switch the relation name
				switch(relation)
				{
					case "grandparent":
						relationPrefix += "great-";
						break;
					case "parent":
						relation = "grandparent";
						break;
					case "spouse":
						relation = "parent";
						break;
					case "pibling":
						relationPrefix += "great-";
						break;
					case "sibling":
						relation = "pibling";
						break;
					case "nibling":
						relation = "cousin";
						break;
					case "child":
						relation = "sibling";
						break;
				}
				
				h[1] = relationPrefix + relation;				
				ds_list_set(newRelatives, i, h);
			}

			//Log("\n\nRelations translated:\n" + string(ListToArray(newRelatives)));
			// change the other children to siblings
			
			

			// log
			/*
			for (var i = 0; i < ds_list_size(newRelatives); i++)
			{
				var h = newRelatives[| i];
				Log(h);
				Log(h[4] + ", " + Genderfy(h));
			}
			*/
			
			// set baby's relatives to newRelatives
			ds_list_copy(inst.relatives, newRelatives);			
			
			for (var i = 0; i < ds_list_size(inst.relatives); i++)
			{
				// look through all of my relatives and add me in them with the reflected relation
				var h = inst.relatives[|i ];
				if (instance_exists(h[0]))
				{
					AddRelative(h[0], inst, ReflectRelation(FindRelation(inst, h[0])));
				}
			}
			
			// reflect relation in all siblings
			var children = FindChildren(father, true);
			//Log(father.name + " has the following children: \n" + string(children));
			for (var i = 0; i < array_length_1d(children); i++)
			{
				var child = children[i];
				if instance_exists(child)
				{
					if (string_count("step-", FindRelation(child, mother)) == 0)
					{
						SetRelation(child, inst, "step-sibling");
					}
					else
					{
						SetRelation(child, inst, "sibling");
					}
				}
			}
			
			//Log("\n\Child relations translated:\n" + string(ListToArray(newRelatives)));
			/*
			// cycle through baby.relatives and mirror the relation
			for (var i = 0; i < ds_list_size(inst.relatives); i++)
			{
				var alreadyAdded = false;
				var h = inst.relatives[| i];
				
				for (var j = 0; j < array_length_1d(children); j++)
				{
					var child = children[j];
					if (child == h)
					{
						alreadyAdded = true;
					}
					
				}
				
				if (!alreadyAdded)
				{
					AddRelative(h[0], inst, ReflectRelation(FindRelation(inst, h[0])));
				}
			}*/
			
			// set the child's head of household
			inst.headOfHousehold = headOfHousehold;
			
			break;			
	}
}