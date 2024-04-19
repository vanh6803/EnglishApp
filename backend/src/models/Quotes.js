const mongoose = require("mongoose");

const QuotesSchema = new mongoose.Schema(
  {
    quote: String,
    author: String,
  },
  { timestamps: true }
);

let quotes = mongoose.model("Quotes", QuotesSchema);

module.exports = {
    quotes,
};
