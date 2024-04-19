const { englishWord } = require("../models/EnglishWord");

const getWordRandomToday = async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 10;
    const data = await englishWord.aggregate([{ $sample: { size: limit } }]);

    return res
      .status(200)
      .json({ code: 200, result: data, message: "get data successfully" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

const getAllWord = async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 15;

    const { topic, word_type } = req.query;

    const totalCount = await englishWord.countDocuments();
    const totalPages = Math.ceil(totalCount / limit);
    const currentPage = Math.min(page, totalPages);
    const skip = (currentPage - 1) * limit;
    const query = {};
    if (topic !== "") query.topic = topic;
    if (word_type !== "") query.word_type = word_type;

    const data = await englishWord.find(query).skip(skip).limit(limit);

    return res.status(200).json({
      code: 200,
      result: data,
      currentPage: currentPage,
      totalPages: totalPages,
      message: "get data successfully",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ code: 500, message: "internal error" });
  }
};

module.exports = {
  getWordRandomToday,
  getAllWord,
};
