import fsp from "node:fs/promises";
import path from "node:path";

import config from "./config.js";
import db from "./db.js";
import hash from "./hash.js";
import logger from "./logger.js";
import staticServer from "./static.js";

const apiPath = path.join(process.cwd(), "./api");

const sandbox = {
  common: { hash },
  console: Object.freeze(logger),
  db: Object.freeze(db(config.db)),
};

const transport = (await import(`./transport/${config.api.transport}.js`))
  .default;

(async () => {
  const files = await fsp.readdir(apiPath);
  const routing = {};

  for (const fileName of files) {
    if (!fileName.endsWith(".js")) continue;

    const filePath = path.join(apiPath, fileName);
    const serviceName = path.basename(fileName, ".js");
    const route = (await import(filePath))?.default;
    routing[serviceName] = route(sandbox);
  }

  transport(routing, config.api.port, logger);

  staticServer("./static", config.static.port, logger);
})();
