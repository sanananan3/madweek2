const express = require('express');
const { Client } = require('pg'); //postgres 모듈 가져오기
const bcrypt = require('bcrypt'); // 비밀번호 해싱하기 위해서 bcrypt 라이브러리 추가하기
const uid = require('uid-safe').sync;

const app = express();
const port = 8000;

app.use(express.json());

const client = new Client({
  user: 'postgres',
  host: 'localhost',
  database: 'madweek2',
  password: '1234',
  port: 5432,
}); // 초기 설정으로 옵션에 데이터베이스에 접속

client.connect(); // 데이터베이스에 접속함

app.post('/register', async (req, res) => {
  try {
    const { user_id, user_pw, name, call, birth } = req.body;
    const hashedPassword = await bcrypt.hash(user_pw, 10);
    const randomToken = uid(24);

    const result = await client.query(
      'INSERT INTO users (user_id, user_pw, name, call, birth, token) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [user_id, hashedPassword, name, call, birth, randomToken]
    );

    res.status(200).json({ success: true, user: result.rows[0] });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

app.post('/register/kakao', async (req, res) => {
  try {
    const { kakao_id, name, call, birth } = req.body;
    const randomToken = uid(24);

    const result = await client.query(
      'INSERT INTO users (kakao_id, name, call, birth, token) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [kakao_id, name, call, birth, randomToken]
    );

    res.status(200).json({ success: true, user: result.rows[0] });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

app.post('/login', async (req, res) => {
  try {
    const { user_id, user_pw, kakao_id } = req.body;

    if (user_id && user_pw) {
      //일반 로그인
      const result = await client.query(
        'SELECT * FROM users WHERE user_id = $1',
        [user_id]
      );

      if (result.rows.length == 0) {
        return res
          .status(401)
          .json({ success: false, error: '존재하지 않는 계정입니다.' });
      }

      const isPasswordValid = await bcrypt.compare(
        user_pw,
        result.rows[0].user_pw
      );

      if (!isPasswordValid) {
        return res
          .status(401)
          .json({ success: false, error: '비밀번호가 일치하지 않습니다.' });
      }

      return res.status(200).json({ success: true, user: result.rows[0] });
    }

    if (kakao_id) {
      //카카오 로그인
      const result = await client.query(
        'SELECT * FROM users WHERE kakao_id = $1',
        [kakao_id]
      );

      if (result.rows.length == 0) {
        return res
          .status(401)
          .json({ sucess: false, error: '존재하지 않는 계정입니다.' });
      }

      return res.status(200).json({ success: true, user: result.rows[0] });
    }

    res.status(500).json({ success: false });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

app.post('/verify', async (req, res) => {
  try {
    const { token } = req.body;

    const result = await client.query(
      'SELECT * FROM users WHERE user_id = $1',
      [token]
    );

    if (result.rows.length == 0) {
      return res
        .status(401)
        .json({ success: false, error: '잘못된 토큰입니다.' });
    }

    res.status(200).json({ success: true, user: result.rows[0] });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
