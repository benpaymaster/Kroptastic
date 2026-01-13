const express = require('express');
const router = express.Router();
const Notification = require('../models/Notification');

// POST /api/notifications - create a notification
router.post('/', async (req, res) => {
  try {
    const notification = new Notification(req.body);
    await notification.save();
    res.status(201).json(notification);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// GET /api/notifications - list all notifications (optionally filter by recipientType or recipientId)
router.get('/', async (req, res) => {
  try {
    const filter = {};
    if (req.query.recipientType) filter.recipientType = req.query.recipientType;
    if (req.query.recipientId) filter.recipientId = req.query.recipientId;
    const notifications = await Notification.find(filter).sort({ createdAt: -1 });
    res.json(notifications);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
