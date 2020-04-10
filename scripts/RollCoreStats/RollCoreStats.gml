/// @func RollCoreStats()
/// @desc returns an array with the 6 core stats generated via weighted RNG

var weight = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
var coreStats = [0, 0, 0, 0, 0, 0];

for (var i = 0; i < array_length_1d(coreStats); i++)
{
	coreStats[i] = weight[irandom_range(0, array_length_1d(weight) - 1)];
}

return coreStats;