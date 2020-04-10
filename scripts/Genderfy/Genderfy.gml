/// @func GetGenderedRelation(relativeElement)
/// @desc returns a gender specific relation (string) for logging
/// @arg relativeElement (array) the relative element to parse for a gender specific relation

var re = argument0;
var h = re[0];
var text = re[1];

if (instance_exists(h))
{
	switch(h.sex)
	{
		case "female":
			switch(re[1])
			{
				case "grandparent":
					text = "grandmother";
					break;
				case "parent":
					text = "mother";
					break;
				case "step-parent":
					text = "step-mother";
					break;
				case "child":
					text = "daughter";
					break;
				case "step-child":
					text = "step-daughter";
					break;
				case "sibling":
					text = "sister";
					break;
				case "spouse":
					text = "wife";
					break;
				case "pibling":
					text = "aunt";
					break;
				case "cousin":
					text = "cousin";
					break;
				case "nibling":
					text = "niece";
					break;
			}
			break;
		
		case "male":
			switch(re[1])
			{
				case "grandparent":
					text = "grandfather";
					break;
				case "parent":
					text = "father";
					break;
				case "step-parent":
					text = "step-father";
					break;
				case "child":
					text = "son";
					break;
				case "step-child":
					text = "step-son";
					break;
				case "sibling":
					text = "brother";
					break;
				case "spouse":
					text = "husband";
					break;
				case "pibling":
					text = "uncle";
					break;
				case "cousin":
					text = "cousin";
					break;
				case "nibling":
					text = "nephew";
					break;
			}
			break;
	}
}

return text;