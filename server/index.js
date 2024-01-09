require('dotenv').config();
require('./db');

const middleware = require('./middleware');
const tweetController = require('./controllers/tweet');
const userController = require('./controllers/user');

const bodyParser = require('body-parser');
const compression = require('compression');
const express = require('express');
const os = require('os');
const app = express();

app.set('port', process.env.PORT || 8000);
app.use(compression());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.post('/register', userController.register);
app.post('/register/kakao', userController.registerKakao);
app.post('/login', userController.login);
app.post('/verify', userController.verify);
app.post('/search', userController.search);

app.get('/tweet', middleware.isAuthenticated, tweetController.getTweet);
app.get('/tweet/my', middleware.isAuthenticated, tweetController.getMyTweet);
app.post('/tweet', middleware.isAuthenticated, tweetController.writeTweet);
app.patch('/tweet', middleware.isAuthenticated, tweetController.editTweet);
app.delete('/tweet', middleware.isAuthenticated, tweetController.deleteTweet);

app.listen(app.get('port'), () => {
  console.log(
    '  Server is running at %s:%d in %s mode',
    os.networkInterfaces()['en0'].find((e) => e.family === 'IPv4').address,
    app.get('port'),
    app.get('env')
  );
  console.log('  Press CTRL-C to stop\n');
});
