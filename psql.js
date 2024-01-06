const express = require ("express");
const { Client } = require ("pg"); //postgres 모듈 가져오기 
const bcrypt = require ("bcrypt"); // 비밀번호 해싱하기 위해서 bcrypt 라이브러리 추가하기 

const app = express();
const port = 8000;

app.use(express.json());

const client = new Client({

    user: "postgres",
    host: "localhost",
    database: "madweek2",
    password: "1234",
    port: 5432
}); // 초기 설정으로 옵션에 데이터베이스에 접속 

client.connect(); // 데이터베이스에 접속함 

app.post("/register", async (req, res)=> {
    try {

        const {user_id, user_pw, name, call, birth } = req.body;

        const hashedPassword = await bcrypt.hash (user_pw, 10);

        const result = await client.query (

            "INSERT INTO users (user_id, user_pw, name, call, birth) VALUES ($1, $2, $3, $4, $5) RETURNING *", [user_id, hashedPassword, name, call, birth]
        );

        res.status(200).json({success: true, user: result.rows[0]});

    }catch (error) {
        res.status(500).json({error: error.message});

    }
});

app.post("/kakaoregister",async(req,res)=> {

    try {
        const {kakao_id, name, call, birth } = req.body;
        const result = await client.query (
            "INSERT INTO users (kakao_id, name, call, birth) VALUES ($1,$2,$3,$4) RETURNING *", [kakao_id, name, call, birth]

        );

        res.status(200).json({success: true, user: result.rows[0]});


    } catch (error) {
        res.status(500).json({error: error.message});
    }
});


app.listen(port, () => {
    console.log('Server is running on port ${port}');
});

