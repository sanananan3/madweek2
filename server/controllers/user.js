const { eq, ilike, or, sql } = require('drizzle-orm');

const bcrypt = require('bcrypt');
const cookie = require('cookie-signature');
const db = require('../db');
const schema = require('../schema');
const uid = require('uid-safe').sync;

const { TOKEN_SECRET } = process.env;

function signUser(user) {
  return Object.assign(user, { token: cookie.sign(user.token, TOKEN_SECRET) });
}

exports.register = async (req, res) => {
  try {
    const { user_id, user_pw, name, phone, birth_date } = req.body;
    const hashedPassword = await bcrypt.hash(user_pw, 10);
    const token = uid(24);

    const result = await db
      .insert(schema.users)
      .values({
        user_id,
        user_pw: hashedPassword,
        name,
        phone,
        birth_date: sql`to_date(${birth_date},'YYYYMMDD')`,
        token,
      })
      .returning();

    res.status(200).json({ success: true, user: signUser(result[0]) });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.registerKakao = async (req, res) => {
  try {
    const { kakao_id, name, phone, birth_date } = req.body;
    const token = uid(24);

    const result = await db
      .insert(schema.users)
      .values({
        kakao_id,
        name,
        phone,
        birth_date: sql`to_date(${birth_date},'YYYYMMDD')`,
        token,
      })
      .returning();

    res.status(200).json({ success: true, user: signUser(result[0]) });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    const { user_id, user_pw, kakao_id } = req.body;

    if (user_id && user_pw) {
      const result = await db
        .select()
        .from(schema.users)
        .where(eq(schema.users.user_id, user_id))
        .limit(1);

      if (result.length === 0) {
        return res
          .status(401)
          .json({ success: false, error: '존재하지 않는 계정입니다.' });
      }

      const user = result[0];
      const isPasswordValid = await bcrypt.compare(user_pw, user.user_pw);
      if (!isPasswordValid) {
        return res
          .status(401)
          .json({ success: false, error: '비밀번호가 일치하지 않습니다.' });
      }

      return res.status(200).json({ success: true, user: signUser(user) });
    }

    if (kakao_id) {
      const result = await db
        .select()
        .from(schema.users)
        .where(eq(schema.users.kakao_id, kakao_id))
        .limit(1);

      if (result.length === 0) {
        return res
          .status(401)
          .json({ success: false, error: '존재하지 않는 계정입니다.' });
      }

      return res.status(200).json({ success: true, user: signUser(result[0]) });
    }

    res.status(500).json({ success: false });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.verify = async (req, res) => {
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

    res.status(200).json({ success: true, user: signUser(result[0]) });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.search = async (req, res) => {
  try {
    const { search } = req.body;

    if (!search || search.length < 2) {
      return res
        .status(400)
        .json({ success: false, error: '검색어는 2글자 이상이어야 합니다.' });
    }

    const result = await db
      .select()
      .from(schema.users)
      .where(
        or(
          ilike(schema.users.user_id, `%${search}%`),
          ilike(schema.users.name, `%${search}%`),
          ilike(schema.users.phone, `%${search}%`)
        )
      );

    res.status(200).json({ success: true, users: result });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
