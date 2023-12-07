const fs = require('fs');
const path = require('path');

function replaceEndpoint(filePath, endpoint) {
  let html = fs.readFileSync(filePath, 'utf8');
  html = html.replace('%%API_ENDPOINT%%', endpoint);
  fs.writeFileSync(filePath, html, 'utf8');
}

const endpoint = process.env.API_ENDPOINT || 'default-endpoint';
const filePath = path.join(__dirname, 'index.html');
replaceEndpoint(filePath, endpoint);
