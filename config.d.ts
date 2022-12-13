declare const config: {
  api: {
    port: number;
    transport: "http" | "https";
  };
  db: {
    database: string;
    host: string;
    password: string;
    port: number;
    user: string;
  };
  pg: {
    database: string;
    password: string;
    user: string;
  };
  sandbox: {
    displayErrors: boolean;
    timeout: number;
  };
  static: {
    port: number;
  };
};

export default config;
