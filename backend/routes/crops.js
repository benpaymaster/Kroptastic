
const express = require('express');
const router = express.Router();
const CropMetric = require('../models/CropMetric');
const { predictHarvestReadiness } = require('../utils/prediction');

// POST /api/crops - submit crop metrics

// POST /api/crops - submit crop metrics and get harvest prediction
router.post('/', async (req, res) => {
	try {
		const cropMetric = new CropMetric(req.body);
		await cropMetric.save();
		// Run AI prediction
		const prediction = predictHarvestReadiness(req.body);

		// Create notifications for farmer and malster
		const Notification = require('../models/Notification');
		const notifications = [];
		// Farmer notification
		notifications.push(new Notification({
			recipientType: 'farmer',
			recipientId: req.body.farmerId || 'farmer',
			message: prediction.message,
			cropMetricId: cropMetric._id
		}));
		// Malster notification
		notifications.push(new Notification({
			recipientType: 'malster',
			recipientId: req.body.malsterId || 'malster',
			message: `Farmer submitted crop metrics. ${prediction.message}`,
			cropMetricId: cropMetric._id
		}));
		await Notification.insertMany(notifications);

		res.status(201).json({ cropMetric, prediction });
	} catch (err) {
		res.status(400).json({ error: err.message });
	}
});

// GET /api/crops - list all crop metrics
router.get('/', async (req, res) => {
	try {
		const metrics = await CropMetric.find().sort({ createdAt: -1 });
		res.json(metrics);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

module.exports = router;
