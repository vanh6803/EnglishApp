const express = require("express");
const cors = require("cors");
const path = require("path");
require("dotenv").config();
require("./src/config/DBConfig");

const englishWordsRouter = require("./src/routers/EnglishWordRouter");
const quoteRouter = require("./src/routers/QuotesRouter");

const app = express();
const port = process.env.PORT || 3000;

app.use((req, res, next) => {
  console.log(
    `[${new Date().toLocaleString()}] ${req.method} ${req.originalUrl} ${
      res.statusCode
    } ${res.get("Content-Length") || "-"} ${
      res.get("X-Response-Time") || "-"
    } ms`
  );
  next();
});

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

app.use("/api/words", englishWordsRouter);
app.use("/api/quotes", quoteRouter);

app.listen(port, () => {
  console.log(`http://localhost:${port}`);
});

module.exports = app;
