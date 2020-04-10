randomize();
// sets a new seed for the randomizer so we get a different "randomness" every time

global.dragging = false;
// used as a singleton for determining which human to drag

global.player = -1;
// the human id of the current player human (will be switchable via right click soon)

global.year = 1;
// keep track of simulation time

simulationEndYear = 200;
// how many years does the simulation last?

initialSettlers = 10;
// how many settlers found the town?

townName = "Janestown";
// initial town name

simulateSpacer = 60;
// how many frames to wait before simulating the next "frame" (default is 60 steps = 1 second)

simulateTimer = 0;
// resets to simulatSpacer after every frame of the simulation to wait

global.simulating = false;
// can the humans simulate right now or pause

global.logList = ds_list_create();
// list for holding all of the text logs and displaying them in game (WIP)

global.coreStatsNames = ["strength", "dexterity", "constitution", "intelligence", "knowledge", "charisma"];
// core stats, currently cosmetic

global.birthRates = [[14, 0], [19, 1.9], [24, 7.1], [29, 9.8], [34, 10], [39, 5.23], [44, 1.16], [54, 0.1], [150, 0], [10000, 100], [10001, 0], [1000000, 0]];
// birth rates by [[maxAge, birthRate]]

global.causesOfDeath = ["cancer", "heart disease", "lung disease", "violence", "self-harm", "accident", "respiratory infection", "disease", "dementia", "natural causes"];
// a simple array containing all causes of death. The maps below are not indexable, so we use this array to see the total number of causesOfDeath

// death rate stats based on WHO data
// the complete data structure is an array of maps (as opposed to maps of arrays like global.faces)
deathRatesBabies = ds_map_create();
deathRatesBabies[? "cancer"] = 1;
deathRatesBabies[? "heart disease"] = 0;
deathRatesBabies[? "lung disease"] = 3;
deathRatesBabies[? "violence"] = 1;
deathRatesBabies[? "self-harm"] = 0;
deathRatesBabies[? "accident"] = 2;
deathRatesBabies[? "respiratory infection"] = 2;
deathRatesBabies[? "disease"] = 3;
deathRatesBabies[? "dementia"] = 0;
deathRatesBabies[? "natural causes"] = 0;

deathRatesKids = ds_map_create();
deathRatesKids[? "cancer"] = 1;
deathRatesKids[? "heart disease"] = 0;
deathRatesKids[? "lung disease"] = 3;
deathRatesKids[? "violence"] = 1;
deathRatesKids[? "self-harm"] = 0;
deathRatesKids[? "accident"] = 5;
deathRatesKids[? "respiratory infection"] = 4;
deathRatesKids[? "disease"] = 1;
deathRatesKids[? "dementia"] = 0;
deathRatesKids[? "natural causes"] = 0;

deathRatesYoungAdults = ds_map_create();
deathRatesYoungAdults[? "cancer"] = 1;
deathRatesYoungAdults[? "heart disease"] = 0;
deathRatesYoungAdults[? "lung disease"] = 3;
deathRatesYoungAdults[? "violence"] = 1;
deathRatesYoungAdults[? "self-harm"] = 0;
deathRatesYoungAdults[? "accident"] = 2;
deathRatesYoungAdults[? "respiratory infection"] = 2;
deathRatesYoungAdults[? "disease"] = 3;
deathRatesYoungAdults[? "dementia"] = 0;
deathRatesYoungAdults[? "natural causes"] = 0;

deathRatesAdults = ds_map_create();
deathRatesAdults[? "cancer"] = 1;
deathRatesAdults[? "heart disease"] = 2;
deathRatesAdults[? "lung disease"] = 3;
deathRatesAdults[? "violence"] = 5;
deathRatesAdults[? "self-harm"] = 3;
deathRatesAdults[? "accident"] = 3;
deathRatesAdults[? "respiratory infection"] = 2;
deathRatesAdults[? "disease"] = 1;
deathRatesAdults[? "dementia"] = 0;
deathRatesAdults[? "natural causes"] = 0;

deathRatesSeniors = ds_map_create();
deathRatesSeniors[? "cancer"] = 3;
deathRatesSeniors[? "heart disease"] = 1;
deathRatesSeniors[? "lung disease"] = 4;
deathRatesSeniors[? "violence"] = 5;
deathRatesSeniors[? "self-harm"] = 4;
deathRatesSeniors[? "accident"] = 1;
deathRatesSeniors[? "respiratory infection"] = 4;
deathRatesSeniors[? "disease"] = 1;
deathRatesSeniors[? "dementia"] = 0;
deathRatesSeniors[? "natural causes"] = 0;

deathRatesElders = ds_map_create();
deathRatesElders[? "cancer"] = 1;
deathRatesElders[? "heart disease"] = 4;
deathRatesElders[? "lung disease"] = 4;
deathRatesElders[? "violence"] = 5;
deathRatesElders[? "self-harm"] = 3;
deathRatesElders[? "accident"] = 3;
deathRatesElders[? "respiratory infection"] = 10;
deathRatesElders[? "disease"] = 3;
deathRatesElders[? "dementia"] = 10;
deathRatesElders[? "natural causes"] = 10;

deathRatesImmortals = ds_map_create();
deathRatesImmortals[? "cancer"] = 5;
deathRatesImmortals[? "heart disease"] = 10;
deathRatesImmortals[? "lung disease"] = 7;
deathRatesImmortals[? "violence"] = 5;
deathRatesImmortals[? "self-harm"] = 2;
deathRatesImmortals[? "accident"] = 3;
deathRatesImmortals[? "respiratory infection"] = 15;
deathRatesImmortals[? "disease"] = 7;
deathRatesImmortals[? "dementia"] = 20;
deathRatesImmortals[? "natural causes"] = 20;

global.deathRates = [
					[4, deathRatesBabies], 
					[14, deathRatesKids],
					[29, deathRatesYoungAdults], 
					[49, deathRatesAdults],
					[59, deathRatesSeniors],
					[69, deathRatesElders],
					[1000000, deathRatesImmortals]
					];

femaleFirstNames = ds_list_create();
maleFirstNames = ds_list_create();
lastNames = ds_list_create();
townNames = ds_list_create();
// random names

ds_list_add(femaleFirstNames, "Abigail","Adelaide","Agata","Aida","Alberta","Alina","Alisa","Alissa","Amanda","Amelia","Anna","Annabella","April","Arianna","Audrey","Belinda","Briony","Brooke","Cadie","Camila","Carina","Caroline","Catherine","Charlotte","Chloe","Connie","Daisy","Edith","Eleanor","Ellia","Emily","Florrie","Grace","Hailey","Heather","Isabella","Jasmine","Jenna","Jessica","Julia","Kimberly","Kirsten","Lana","Lilianna","Lucia","Lucy","Madaline","Maya","Melanie","Michelle","Miley","Naomi","Natalie","Olivia","Paige","Penelope","Rebecca","Samantha","Sarah","Sienna","Sofia","Stella","Tara","Tess","Tiana","Violet","Vivian","Jane", "Vanessa", "Ashley", "Bree", "Cathorine", "Diane", "Emma", "Ava", "Olivia", "Isabella", "Amelia", "Mia", "Evelyn", "Charlotte", "Sophia", "June");
ds_list_add(maleFirstNames, "Abraham","Adam","Adison","Aiden","Alan","Albert","Aldus","Alen","Alexander","Antony","Arnold","Arthur","Ashton","Aston","Brad","Bruce","Carl","Carlos","Charlie","Dale","Daniel","David","Dominik","Edwin","Elian","Freddie","Frederick","George","Haris","Harold","Henry","Jack","Jacob","James","Jared","Julian","Justin","Kellan","Kelvin","Kevin","Leonardo","Lucas","Luke","Lyndon","Martin","Max","Maximilian","Michael","Mike","Nicholas","Oliver","Richard","Roland","Sam","Sawyer","Steven","Ted","Tony","Tyler","Vincent","Walter","Wilson", "John", "Victor", "Winston", "Wayne", "Randall", "Bernard", "William", "Clint", "Jeffrey", "Liam", "Noah", "Logan", "James", "Oliver", "Elijah", "Benjamin", "Lucas", "Mason");
ds_list_add(lastNames, "Allen","Anderson","Andrews","Armstrong","Bailey","Baker","Barnes","Barrett","Bennett","Brooks","Brown","Cameron","Campbell","Carroll","Carter","Chapman","Clark","Cole","Cooper","Craig","Cunningham","Davis","Dixon","Douglas","Edwards","Ellis","Evans","Farrell","Foster","Fowler","Gray","Hall","Hamilton","Hawkins","Henderson","Holmes","Johnson","Johnston","Jones","Kelley","Lloyd","Martin","Mason","Mitchell","Montgomery","Morgan","Morrison","Murphy","Murray","Myers","Nelson","Owens","Payne","Perry","Reed","Richards","Richardson","Roberts","Robinson","Rogers","Ross","Russell","Ryan","Scott","Spencer","Stevens","Thomas","Thompson","Tucker","Turner","Walker","Wells","Williams","Wilson","Wright", "Smith", "Hutchins", "Roade", "Williams", "Burnes", "Hodges", "Goldstein", "Goldbear", "Hoyt", "Harper", "Johnson", "Miller", "Wilson", "Moore", "Anderson", "White", "Jackson", "Wright", "Young", "Cox", "Patterson", "Long", "Harris", "Baker", "Adams", "Cooper", "Cook", "Rogers");
ds_list_add(townNames, "Bridgara", "Mount Warbeth", "Las Bundaragas", "Hillgate", "Flinville", "North Ganut", "Cape Laygold", "Saint Lichet");
// add some names

global.faces = ds_map_create();
global.faces[? "f0"] = [sFemaleBaby, sFemaleKid, sFemaleYoungAdult, sFemaleAdult, sFemaleMatureAdult, sFemaleSenior];
global.faces[? "m0"] = [sMaleBaby, sMaleKid, sMaleYoungAdult, sMaleAdult, sMaleMatureAdult, sMaleSenior];
// sprite map for the human faces based on age. each mapped element is an array that can be iterated through based on human.ageBrackets to get the aged face

townName = GetRandomTownName();
Log(townName + " is founded with the arrival of " + string(initialSettlers) +  " settlers.");
SpawnHuman("random", initialSettlers);
// initialize the simulation