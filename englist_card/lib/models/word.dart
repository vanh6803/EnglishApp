class EnglishWord {
  String? id;
  String? word;
  String? meaning;
  String? pronunciation;
  String? wordType;
  String? exampleSentence;
  String? topic;
  EnglishWord(
      {this.id,
      this.word,
      this.meaning,
      this.pronunciation,
      this.wordType,
      this.exampleSentence,
      this.topic});

  EnglishWord.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    word = json['word'];
    meaning = json['meaning'];
    pronunciation = json['pronunciation'];
    wordType = json['word_type'];
    topic = json['topic'];
    exampleSentence = json['example_sentence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['word'] = word;
    data['meaning'] = meaning;
    data['pronunciation'] = pronunciation;
    data['word_type'] = wordType;
    data['topic'] = topic;
    data['example_sentence'] = exampleSentence;
    return data;
  }
}
