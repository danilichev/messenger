export default {
  api: {
    port: 8001,
    transport: "http",
  },
  db: {
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
  },
  sandbox: {
    displayErrors: false,
    timeout: 5000,
  },
  static: {
    port: 8000,
  },
};
