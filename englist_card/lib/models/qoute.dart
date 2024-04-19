class Quote {
  	String? id;
	String? quote;
	String? author;

	Quote({this.id, this.quote, this.author});

	Quote.fromJson(Map<String, dynamic> json) {
		id = json['_id'];
		quote = json['quote'];
		author = json['author'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['_id'] = id;
		data['quote'] = quote;
		data['author'] = author;
		return data;
	}
}