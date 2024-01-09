const { desc, eq, not } = require('drizzle-orm');

const db = require('../db');
const schema = require('../schema');

exports.getTweet = async (req, res) => {
  try {
    const user_id = req.user.id;
    const result = await db
      .select()
      .from(schema.tweets)
      .where(not(eq(schema.tweets.user_id, user_id)))
      .orderBy(desc(schema.tweets.created_at));

    res.status(200).json({ success: true, tweets: result });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.getMyTweet = async (req, res) => {
  try {
    const user_id = req.user.id;
    const result = await db
      .select()
      .from(schema.tweets)
      .where(eq(schema.tweets.user_id, user_id))
      .orderBy(desc(schema.tweets.created_at));

    res.status(200).json({ success: true, tweets: result });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.writeTweet = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { content } = req.body;

    const result = await db
      .insert(schema.tweets)
      .values({
        content,
        user_id,
      })
      .returning();

    res.status(200).json({ success: true, tweets: result });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.editTweet = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { id, content } = req.body;

    const result = await db
      .select()
      .from(schema.tweets)
      .where(eq(schema.tweets.id, id))
      .limit(1);

    if (result.length === 0) {
      return res
        .status(401)
        .json({ success: false, error: '존재하지 않는 트윗입니다.' });
    }

    const tweet = result[0];

    if (tweet.user_id !== user_id) {
      return res
        .status(401)
        .json({ success: false, error: '트윗의 작성자가 아닙니다.' });
    }

    await db
      .update(schema.tweets)
      .set({ content })
      .where(eq(schema.tweets.id, id));

    res.status(200).json({
      success: true,
      tweets: [Object.assign(tweet, { content })],
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.deleteTweet = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { id } = req.body;

    const result = await db
      .select()
      .from(schema.tweets)
      .where(eq(schema.tweets.id, id))
      .limit(1);

    if (result.length === 0) {
      return res
        .status(401)
        .json({ success: false, error: '존재하지 않는 트윗입니다.' });
    }

    const tweet = result[0];

    if (tweet.user_id !== user_id) {
      return res
        .status(401)
        .json({ success: false, error: '트윗의 작성자가 아닙니다.' });
    }

    await db.delete(schema.tweets).where(eq(schema.tweets.id, id));

    res.status(200).json({ success: true, tweets: result });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
