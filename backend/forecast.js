const express = require('express');
const app = express();
const PORT = process.env.PORT || 3001;

// Simple endpoint for Days to Harvest
app.get('/api/days-to-harvest', (req, res) => {
  res.json({ daysToHarvest: 14 }); // Placeholder value
});

app.listen(PORT, () => {
  console.log(`Forecast backend running on port ${PORT}`);
});
