require('dotenv').config();
require('./db');

const middleware = require('./middleware');
const likeController = require('./controllers/like');
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

app.get('/tweet', middleware.isAuthenticated, tweetController.getTweets);
app.get('/tweet/new', middleware.isAuthenticated, tweetController.getNewTweets);
app.post('/tweet', middleware.isAuthenticated, tweetController.writeTweet);
app.patch('/tweet', middleware.isAuthenticated, tweetController.editTweet);
app.delete('/tweet', middleware.isAuthenticated, tweetController.deleteTweet);

app.get('/like', middleware.isAuthenticated, likeController.getMyLikes);
app.post('/like', middleware.isAuthenticated, likeController.doLike);

app.listen(app.get('port'), () => {
  console.log(
    '  Server is running at port %d in %s mode',
    app.get('port'),
    app.get('env')
  );
  console.log('  Press CTRL-C to stop\n');
});
