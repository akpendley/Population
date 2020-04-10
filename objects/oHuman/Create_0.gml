ageBrackets = [4, 14, 24, 34, 49, 64];
// (array) used to determine what age to change the face sprite

ageToChangeFace = ageBrackets[0];
// (number) set the initial age to change faces

birthTown = "Janestown";
// (string) flavor

sex = "female";
// (string) determines whether human can give birth and name selection

firstName = "Jane";
// (string) choose a random name (this will be changed by mothers during birth)

lastName = "Smith";
// (string) choose a random last name (reset by mother)

face = "f0";
// (string) determines sprite image (naming convention is first letter of sex, number)

name = firstName + " " + lastName;
// (string) easy access to the full name

age = 0;
// (number) ticks up each year and is used to determine birth and death rates

coreStats = RollCoreStats();
// (array) flavor (WIP)

relatives = ds_list_create();
// (list of arrays) off limits humans
// [(number) id,
//  (string) relation,
//  (string) first name, 
//  (string) last name, 
//  (string) full name, 
//  (string) birth town] 

headOfHousehold = noone;
// (id) points to the head of household human

moveSpeeds = [1, 3, 6, 10];
// (array) all default move speeds

moveSpeed = 1;
// (number) selector for move speed

offsetLength = 100;
// (number) radius from center of sprite image for drawing dependents

offsetDirection = irandom_range(200, 340);
// (number) represents a random arc along which dependent sprites will be drawn

dragging = false;
// (boolean) for left clicking and moving with the mouse

infection = false;
// (boolean) flags to kill 20% of people next year

mourning = false;
// (boolean) used to keep humans from engaging in strange activities after death, like immediate remarriage or birth

deathCase = "natural causes";
// (string) used to log cause of death

x = irandom_range(room_width * 0.3, room_width * 0.9);
y = irandom_range(room_height * 0.3, room_height * 0.9);
// set the initial x y to a random position in the right part of the room