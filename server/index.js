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
    res.status(500).json({ error: error.message });
  }
});

app.post('/kakaoregister', async (req, res) => {
  try {
    const { kakao_id, name, call, birth } = req.body;
    const randomToken = uid(24);

    const result = await client.query(
      'INSERT INTO users (kakao_id, name, call, birth, token) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [kakao_id, name, call, birth, randomToken]
    );
    res.status(200).json({ success: true, user: result.rows[0] });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/login', async (req, res) => {
  try {
    const { user_id, user_pw, kakao_id } = req.body;

    if ((user_id && user_pw) || kakao_id) {
      let result;

      if (user_id && user_pw) {
        //일반 로그인
        result = await client.query('SELECT * FROM users WHERE user_id = $1', [
          user_id,
        ]);

        if (result.rows.length == 0) {
          return res
            .status(401)
            .json({ success: false, message: 'Invalid user_id or password' });
        }

        const isPasswordValid = await bcrypt.compare(
          user_pw,
          result.rows[0].user_pw
        );

        if (!isPasswordValid) {
          return res
            .status(401)
            .json({ success: false, message: 'Invalid user_id or password' });
        }
      } else {
        //카카오 로그인

        result = await client.query('SELECT * FROM users WHERE kakao_id = $1', [
          kakao_id,
        ]);

        if (result.rows.length == 0) {
          return res
            .status(401)
            .json({ sucess: false, message: 'Invalid kakao_id' });
        }
      }

      const token = generateToken(result.rows[0].user_id);

      return res
        .status(200)
        .json({ success: true, user: result.rows[0] }, token);
    } else {
      return res
        .status(400)
        .json({ success: false, message: 'Invalid id and pw' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
