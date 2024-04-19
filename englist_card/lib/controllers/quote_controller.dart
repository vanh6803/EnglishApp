import 'dart:convert';

import 'package:englist_card/api/index.dart';
import 'package:englist_card/models/qoute.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuoteController extends GetxController {
  Rx<Quote?> quote = Rx<Quote?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuote();
  }

  Future<Rx<Quote?>> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse(API_QUOTE));
      print("response: $response");
      final Map<String, dynamic> result = json.decode(response.body);
      print("result: $result");
      if (response.statusCode == 200) {
        quote.value = Quote.fromJson(result);
        print("quote: $quote");
      } else {
        print("Failed to load quote, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching quote: $e");
    }
    return quote;
  }
}
