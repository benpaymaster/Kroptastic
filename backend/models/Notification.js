const mongoose = require('mongoose');

const NotificationSchema = new mongoose.Schema({
  recipientType: { type: String, enum: ['farmer', 'malster', 'supply_chain'], required: true },
  recipientId: { type: String }, // could be user id, email, or org name
  message: { type: String, required: true },
  cropMetricId: { type: mongoose.Schema.Types.ObjectId, ref: 'CropMetric' },
  createdAt: { type: Date, default: Date.now },
  read: { type: Boolean, default: false }
});

module.exports = mongoose.model('Notification', NotificationSchema);
