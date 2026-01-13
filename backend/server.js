const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const connectDB = require('./db');

const app = express();
connectDB();

app.use(cors());
app.use(bodyParser.json());


// Crop metrics route
const cropsRouter = require('./routes/crops');
app.use('/api/crops', cropsRouter);

// Notifications route
const notificationsRouter = require('./routes/notifications');
app.use('/api/notifications', notificationsRouter);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
