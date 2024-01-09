require('dotenv').config();
require('./db');

const middleware = require('./middleware');
const tweetController = require('./controllers/tweet');
const userController = require('./controllers/user');
const searchController = require('./controllers/search');


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

app.post('/tweet', middleware.isAuthenticated, tweetController.getTweet);
app.post('/tweet/my', middleware.isAuthenticated, tweetController.getMyTweet);
app.post(
  '/tweet/write',
  middleware.isAuthenticated,
  tweetController.writeTweet
);

app.post('/search', searchController.getSearch);

app.listen(app.get('port'), () => {
  console.log(
    '  Server is running at http://localhost:%d in %s mode',
    app.get('port'),
    app.get('env')
  );
  console.log('  Press CTRL-C to stop\n');
});
