const { quotes } = require("../models/Quotes");

const quoteNow = async (req, res) => {
  try {
    const count = await quotes.countDocuments();
    const randomIndex = Math.floor(Math.random() * count);
    const randomQuote = await quotes.findOne().skip(randomIndex);
    console.log(randomQuote);
    return res.status(200).json(randomQuote);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

module.exports = {
  quoteNow,
};
