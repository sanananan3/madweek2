const {
  and,
  desc,
  eq,
  exists,
  inArray,
  getTableColumns,
} = require('drizzle-orm');
const db = require('../db');
const schema = require('../schema');

exports.getLikes = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { id } = req.body;
    const result = await db
      .select({
        ...getTableColumns(schema.tweets),
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
      .where(
        inArray(
          schema.tweets.id,
          db
            .select({ data: schema.likes.tweet_id })
            .from(schema.likes)
            .where(eq(schema.likes.user_id, id))
        )
      )
      .orderBy(desc(schema.tweets.created_at));

    res.status(200).json({ success: true, tweets: result });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.doLike = async (req, res) => {
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

    if (tweet.user_id === user_id) {
      return res.status(401).json({
        success: false,
        error: '자신의 트윗은 좋아요를 할 수 없습니다.',
      });
    }

    await db.insert(schema.likes).values({ user_id, tweet_id: id });

    res.status(200).json({ success: true });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

exports.cancelLike = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { id } = req.body;

    const result = await db
      .select()
      .from(schema.likes)
      .where(
        and(eq(schema.likes.user_id, user_id), eq(schema.likes.tweet_id, id))
      )
      .limit(1);

    if (result.length === 0) {
      return res.status(401).json({
        success: false,
        error: '해당 트윗은 좋아요하지 않았거나 존재하지 않습니다.',
      });
    }

    const like = result[0];

    await db.delete(schema.likes).where(eq(schema.likes.id, like.id));

    res.status(200).json({ success: true });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
