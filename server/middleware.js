const { eq } = require('drizzle-orm');

const cookie = require('cookie-signature');
const db = require('./db');
const schema = require('./schema');

const { TOKEN_SECRET } = process.env;

exports.isAuthenticated = async (req, res, next) => {
  try {
    const signedToken = req.header('Authorization');
    if (!signedToken) {
      return res
        .status(401)
        .json({ success: false, error: '토큰이 존재하지 않습니다.' });
    }

    const token = cookie.unsign(signedToken, TOKEN_SECRET);
    const result = await db
      .select()
      .from(schema.users)
      .where(eq(schema.users.token, token))
      .limit(1);

    if (result.length === 0) {
      return res
        .status(401)
        .json({ success: false, error: '잘못된 토큰입니다.' });
    }

    req.user = result[0];
    next();
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
