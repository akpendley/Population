/// @description simulation timing
if (global.simulating && !keyboard_check(vk_space))
{
	global.simulating = false;
}
// turn off simulation anytime it has remained on since last frame and we aren't manually speeding up the simulation with spacebar

simulateTimer = clamp(simulateTimer - 1, 0, simulateSpacer);
// decrement simulateTimer while keeping it above 0 and below the maximum time (simulateSpacer)

if (simulateTimer == 0)
{
	simulateTimer = simulateSpacer;
	// set simulation timer to delay the next frame of simulation a reasonable amount of time
	global.simulating = true;
}