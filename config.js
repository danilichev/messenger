export default {
  api: {
    port: 8001,
    transport: "http",
  },
  db: {
    database: "example",
    host: "127.0.0.1",
    password: "marcus",
    port: 5432,
    user: "marcus",
  },
  sandbox: {
    displayErrors: false,
    timeout: 5000,
  },
  static: {
    port: 8000,
  },
};
