// age brackets
ageBrackets = [4, 14, 24, 34, 49, 64];

ageToChangeFace = ageBrackets[0];

birthTown = "Janestown";

sex = "female";
// determines whether human can give birth and name selection

firstName = "Jane";
// choose a random name (this will be changed by mothers during birth)

lastName = "Smith";
// choose a random last name (reset by mother)

face = "f0";
// determines sprite image

name = firstName + " " + lastName;
// easy access to the full name

age = 0;
// ticks up each year and is used to determine birth and death rates

coreStats = RollCoreStats();

relatives = ds_list_create();
// list of (id) off limits humans

headOfHousehold = noone;
// (id) points to the head of household human

moveSpeeds = [1, 3, 6, 10];
// array of all default move speeds

moveSpeed = 1;
// selector for move speed

offsetLength = 100;
offsetDirection = irandom_range(200, 340);
// for moving to head of household

dragging = false;
// for left clicking and moving with the mouse

infection = false;
// flags to kill 20% of people next year

mourning = false;
// used to keep humans from engaging in strange activities after death, like immediate remarriage or birth

deathCase = "natural causes";
// used to log cause of death

x = irandom_range(room_width * 0.1, room_width * 0.9);
y = irandom_range(room_height * 0.1, room_height * 0.9);