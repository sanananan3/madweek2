const { drizzle } = require('drizzle-orm/postgres-js');
const { migrate } = require('drizzle-orm/postgres-js/migrator');
const postgres = require('postgres');

const migrationClient = postgres(process.env.POSTGRES_URL, {
  max: 1,
  onnotice: () => {},
});
migrate(drizzle(migrationClient), { migrationsFolder: './drizzle' });

const queryClient = postgres(process.env.POSTGRES_URL);
module.exports = drizzle(queryClient);
