const { and, desc, eq, exists, getTableColumns, not } = require('drizzle-orm');

const db = require('../db');
const schema = require('../schema');

exports.getTweets = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { id } = req.body;
    const result = await db
      .select({
        ...getTableColumns(schema.tweets),
        user: schema.users,
        like: exists(
          db
            .select({ value: 1 })
            .from(schema.likes)
            .where(
              and(
                eq(schema.likes.user_id, user_id),
                eq(schema.likes.tweet_id, schema.tweets.id)
              )
            )
        ),
      })
      .from(schema.tweets)
      .where(eq(schema.tweets.user_id, id))
      .innerJoin(schema.users, eq(schema.tweets.user_id, schema.users.id))
      .orderBy(desc(schema.tweets.created_at));

    res.status(200).json({ success: true, tweets: result });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.getNewTweets = async (req, res) => {
  try {
    const user_id = req.user.id;
    const result = await db
      .select({
        ...getTableColumns(schema.tweets),
        user: schema.users,
        like: exists(
          db
            .select({ value: 1 })
            .from(schema.likes)
            .where(
              and(
                eq(schema.likes.user_id, user_id),
                eq(schema.likes.tweet_id, schema.tweets.id)
              )
            )
        ),
      })
      .from(schema.tweets)
      .where(not(eq(schema.tweets.user_id, user_id)))
      .innerJoin(schema.users, eq(schema.tweets.user_id, schema.users.id))
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
        content: content.trim(),
        user_id,
      })
      .returning();

    res.status(200).json({ success: true, tweet: result[0] });
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
      .set({ content: content.trim() })
      .where(eq(schema.tweets.id, id));

    res.status(200).json({
      success: true,
      tweet: Object.assign(tweet, { content }),
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

    res.status(200).json({ success: true, tweet });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
