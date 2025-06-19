// app.js
const express = require('express');
const app = express();
const PORT = 3000;
const VERSION = process.env.VERSION || "unknown";

app.get('/', (req, res) => {
  res.send(`Hello from ${VERSION} version!`);
});

app.listen(PORT, () => {
  console.log(`Node.js app listening on port ${PORT} [${VERSION}]`);
});
