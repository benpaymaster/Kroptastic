// Simple AI stub for harvest readiness prediction
// Input: metrics object
// Output: { readiness: number (0-100), message: string }

function predictHarvestReadiness(metrics) {
  // Example weights for demonstration
  const weights = {
    soilMoisture: 0.3,
    nitrogenContent: 0.2,
    coloration: 0.2,
    plantColor: 0.1,
    stemColor: 0.1,
    grainMoisture: 0.1
  };

  let score = 0;
  let totalWeight = 0;

  Object.keys(weights).forEach((key) => {
    if (metrics[key]) {
      // Normalize value (assume 0-100 for now)
      score += parseFloat(metrics[key]) * weights[key];
    }
    totalWeight += weights[key];
  });

  // Calculate readiness percentage
  const readiness = Math.min(100, Math.round((score / totalWeight)));
  let message = `Crop is ${readiness}% ready for harvest.`;

  return { readiness, message };
}

module.exports = { predictHarvestReadiness };
