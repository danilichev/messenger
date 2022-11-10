import fs from 'node:fs';
import http from 'node:http';
import path from 'node:path';

const MIME_TYPES = {
  css: 'text/css',
  html: 'text/html; charset=UTF-8',
  ico: 'image/x-icon',
  js: 'application/javascript; charset=UTF-8',
  json: 'application/json; charset=UTF-8',
  png: 'image/png',
  svg: 'image/svg+xml',
};

const HEADERS = {
  'Access-Control-Allow-Headers': 'Content-Type',
  'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
  'Access-Control-Allow-Origin': '*',
  'Strict-Transport-Security': 'max-age=31536000; includeSubdomains; preload',
  'X-Content-Type-Options': 'nosniff',
  'X-XSS-Protection': '1; mode=block',
};

export default (root, port, console) => {
  http
    .createServer(async (req, res) => {
      const url = req.url === '/' ? '/index.html' : req.url;
      const filePath = path.join(root, url);
      try {
        const data = await fs.promises.readFile(filePath);
        const fileExt = path.extname(filePath).substring(1);
        const mimeType = MIME_TYPES[fileExt] || MIME_TYPES.html;
        res.writeHead(200, { ...HEADERS, 'Content-Type': mimeType });
        res.end(data);
      } catch (err) {
        res.statusCode = 404;
        res.end('"File is not found"');
      }
    })
    .listen(port);

  console.log(`Static on port ${port}`);
};
