const mongoose = require('mongoose');

const CropMetricSchema = new mongoose.Schema({
  cropName: { type: String, required: true },
  coloration: String,
  soilMoisture: String,
  nitrogenContent: String,
  carbonContent: String,
  plantColor: String,
  stemColor: String,
  headAngle: String,
  lodging: String,
  uniformRipening: String,
  weedPresence: String,
  grainMoisture: String,
  grainHardness: String,
  screenings: String,
  specificWeight: String,
  proteinContent: String,
  kernelDamage: String,
  notes: String,
  kernelRetention: String,
  germination: String,
  kernelUniformity: String,
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('CropMetric', CropMetricSchema);
