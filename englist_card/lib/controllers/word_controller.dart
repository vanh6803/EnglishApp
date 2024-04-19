import 'dart:convert';

import 'package:englist_card/api/index.dart';
import 'package:englist_card/models/word.dart';
import 'package:englist_card/utils/app_cache_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WordController extends GetxController {
  RxInt limit = 5.obs;
  var words = <EnglishWord>[].obs;
  RxBool isLoading = false.obs;
  var allWords = <EnglishWord>[].obs;
  RxInt page = 1.obs;

  RxString topicSelected = "".obs;
  RxString wordTypeSelected = "".obs;

  ScrollController scrollController = ScrollController();

  RxList<EnglishWord> filteredWords = <EnglishWord>[].obs;
  RxBool isFabVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initLimit().then((_) {
      wordToday(limit.value);
    });
    fetchAllWords(page.value, 20, topicSelected.value, wordTypeSelected.value);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchAllWords(
            page.value + 1, 20, topicSelected.value, wordTypeSelected.value);
      }
    });

    isFabVisible.value = false;
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          scrollController.position.pixels <= 50) {
        isFabVisible.value = false;
      } else {
        isFabVisible.value = true;
      }
    });
  }

  Future<void> _initLimit() async {
    try {
      String? dataCache = await AppCacheData.getCounterToCache();
      int convertDataCache = double.parse(dataCache ?? '0').toInt();
      if (convertDataCache != 0) {
        limit.value = convertDataCache;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<EnglishWord>> wordToday(int limit) async {
    try {
      final response =
          await http.get(Uri.parse('$API_RANDOM_WORD?limit=$limit'));
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<dynamic> result = responseData['result'];
        words.assignAll(result.map((e) => EnglishWord.fromJson(e)));
        print(words.length);
      }
    } catch (e) {
      print(e.toString());
    }

    return words;
  }

  Future<List<EnglishWord>> fetchAllWords(
      int page, int limit, String? topic, String? wordType) async {
    print("$topic, $wordType");
    try {
      final response = await http.get(Uri.parse(
          '$API_ALL_WORD?page=$page&limit=$limit&topic=$topic&word_type=$wordType'));
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<dynamic> result = responseData['result'];
        List<EnglishWord> newWords =
            result.map((e) => EnglishWord.fromJson(e)).toList();
        allWords.addAll(newWords);
        if (topic != null && wordType != null) {
          filterWords(topic, wordType);
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return allWords;
  }

  void filterWords(String topic, String wordType) {
    filteredWords.assignAll(allWords.where((word) {
      return (topic.isEmpty || word.topic == topic) &&
          (wordType.isEmpty || word.wordType == wordType);
    }).toList());
  }

  void scrollToTop() {
    isFabVisible.value = false;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linear,
    );

  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
