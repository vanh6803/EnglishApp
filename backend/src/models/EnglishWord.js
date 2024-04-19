const mongoose = require("mongoose");

const englishWordSchema = new mongoose.Schema(
  {
    word: String,
    meaning: String,
    pronunciation: String,
    word_type: {
      type: String,
      enum: [
        "Nouns",
        "Verbs",
        "Adjectives",
        "Adverbs",
        "Pronouns",
        "Prepositions",
        "Conjunctions",
        "Interjections",
      ],
    },
    example_sentence: String,
    topic: {
      type: String,
      enum: ["Music", "Life", "Sports", "Technology", "Careers", "Education"],
    },
  },
  { timestamps: true }
);

let englishWord = mongoose.model("EnglishWord", englishWordSchema);

module.exports = {
  englishWord,
};
