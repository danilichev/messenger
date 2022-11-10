import http from "node:http";

const HEADERS = {
  "Access-Control-Allow-Headers": "Content-Type",
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
  "Access-Control-Allow-Origin": "*",
  "Content-Type": "application/json; charset=UTF-8",
  "Strict-Transport-Security": "max-age=31536000; includeSubdomains; preload",
  "X-Content-Type-Options": "nosniff",
  "X-XSS-Protection": "1; mode=block",
};

const receiveArgs = async (req) => {
  const buffers = [];
  for await (const chunk of req) buffers.push(chunk);
  const data = Buffer.concat(buffers).toString();
  return JSON.parse(data);
};

export default (routing, port, console) => {
  http
    .createServer(async (req, res) => {
      res.writeHead(200, HEADERS);
      if (req.method !== "POST") return res.end('"Not found1"');
      const { url, socket } = req;
      const [place, name, method] = url.substring(1).split("/");
      if (place !== "api") return res.end('"Not found2"');
      const entity = routing[name];
      if (!entity) return res.end('"Not found3"');
      console.log("entity", entity);
      const handler = entity[method];
      if (!handler) return res.end('"Not found4"');
      const args = await receiveArgs(req);
      console.log(`${socket.remoteAddress} ${method} ${url}`);
      const result = await handler(args);
      res.end(JSON.stringify(result));
    })
    .listen(port);

  console.log(`API on port ${port}`);
};
