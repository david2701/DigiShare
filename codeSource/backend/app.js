const express             = require('express'),
      bodyParser          = require('body-parser'),
      mongoose            = require('mongoose'),
      routerPublications  = require('./routes/publications'),
      routerEmployees     = require('./routes/employees'),
      routerAgencies      = require('./routes/agencies'),
      routerAuth          = require('./routes/auth'),
      NotificationChannel = require('./routes/realtime channels/notifications');

let app = express();

mongoose.connect('mongodb://localhost/digi_share',{ useNewUrlParser: true, useCreateIndex: true, useFindAndModify: false, useUnifiedTopology: true});

let notificationChannel = new NotificationChannel(app.get('io'));

app.use(bodyParser.json());

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    next();
  });

app.use('/api/auth',routerAuth);
app.use('/api/publications', routerPublications);  
app.use('/api/employees', routerEmployees);
app.use('/api/agencies', routerAgencies);





module.exports = app;