const { desc, eq, or, like } = require('drizzle-orm');

const db = require('../db');
const schema = require('../schema');

exports.getSearch = async (req, res) => {
  try {
    const { userId, name, phone, birthDate } = req.body; // Assuming the input comes from the request body

    const result = await db
      .select()
      .from(schema.users)
      .where(
        or(
          eq(schema.users.user_id, userId%),
          eq(schema.users.name, name),
          eq(schema.users.phone, phone)
        )
      );

      console.log(result);

   if (result && result.length > 0) {
         const { name, user_id, phone, birth_date } = result[0];
         res.status(200).json({
           success: true,
           user: result[0],
         });
       } else {
         res.status(404).json({ success: false, message: 'User not found' });
       }
     } catch (error) {
     console.log(error.message);
       res.status(500).json({ success: false, error: error.message });
     }
   };