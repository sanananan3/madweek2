require('dotenv').config();
require('./db');

const userController = require('./controllers/user');

const bodyParser = require('body-parser');
const compression = require('compression');
const express = require('express');
const app = express();

app.set('port', process.env.PORT || 8000);
app.use(compression());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.post('/register', userController.register);
app.post('/register/kakao', userController.registerKakao);
app.post('/login', userController.login);
app.post('/verify', userController.verify);

app.listen(app.get('port'), () => {
  console.log(
    '  Server is running at http://localhost:%d in %s mode',
    app.get('port'),
    app.get('env')
  );
  console.log('  Press CTRL-C to stop\n');
});
