if (global.simulating && !keyboard_check(vk_space))
{
	global.simulating = false;
}
// turn off simulation anytime it has remained on since last frame and we aren't manually speeding up the simulation

simulateTimer = clamp(simulateTimer - 1, 0, simulateSpacer);
// set simulation timer to delay the next frame of simulation a reasonable amount of time

if (simulateTimer == 0)
{
	simulateTimer = simulateSpacer;
	global.simulating = true;
}