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
