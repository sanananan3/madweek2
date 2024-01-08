const { eq } = require('drizzle-orm');

const cookie = require('cookie-signature');
const db = require('./db');
const schema = require('./schema');

const { TOKEN_SECRET } = process.env;

exports.isAuthenticated = async (req, res, next) => {
  try {
    const token = cookie.unsign(req.body.token, TOKEN_SECRET);
    if (!token) {
      return res
        .status(401)
        .json({ success: false, error: '잘못된 토큰입니다.' });
    }

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
