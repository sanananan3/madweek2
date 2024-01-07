const {
  bigint,
  date,
  pgTable,
  serial,
  text,
  timestamp,
  varchar,
} = require('drizzle-orm/pg-core');

exports.users = pgTable('users', {
  id: serial('id').primaryKey(),
  user_id: varchar('user_id', { length: 20 }).unique(),
  user_pw: text('user_pw'),
  kakao_id: bigint('kakao_id', { mode: 'number' }).unique(),
  token: text('token').notNull().unique(),
  name: varchar('name', { length: 10 }).notNull(),
  phone: varchar('phone', { length: 20 }).notNull().unique(),
  birth_date: date('birth_date').notNull(),
  created_at: timestamp('created_at', { withTimezone: true }).defaultNow(),
});
