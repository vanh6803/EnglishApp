import 'package:englist_card/constants/app_assets.dart';
import 'package:englist_card/constants/app_color.dart';
import 'package:englist_card/constants/app_dimen.dart';
import 'package:englist_card/constants/app_heading.dart';
import 'package:englist_card/controllers/word_controller.dart';
import 'package:englist_card/models/word.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AllWordScreen extends StatefulWidget {
  const AllWordScreen({super.key});

  @override
  State<AllWordScreen> createState() => _AllWordScreenState();
}

class _AllWordScreenState extends State<AllWordScreen> {
  final WordController _wordController = Get.put(WordController());
  final FlutterTts flutterTts = FlutterTts();
  final List<String> topics = [
    "Music",
    "Life",
    "Sports",
    "Technology",
    "Careers",
    "Education"
  ];

  final List<String> wordTypes = [
    "Noun",
    "Verb",
    "Adjective",
    "Adverb",
    "Pronoun",
    "Preposition",
    "Conjunction",
    "Interjection"
  ];

  String topicSelected = "";
  String wordTypeSelected = "";

  bool buttonShow = false;

  @override
  void initState() {
    flutterTts.setLanguage('en-US');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,
        elevation: 0,
        leading: InkWell(
          onTap: () async {
            Get.back();
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
        title: Text(
          'All Words',
          style: GoogleFonts.sen(color: AppColor.textColor, fontSize: 36),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: AppDimen.screenWidth * 0.03),
            child: InkWell(
              onTap: _showFilterMenu,
              child: const Icon(
                Icons.filter_list_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          controller: _wordController.scrollController,
          itemCount: _wordController.filteredWords.length,
          // Sử dụng filteredWords thay vì allWords
          itemBuilder: (context, index) {
            EnglishWord englishWord = _wordController
                .filteredWords[index]; // Sử dụng filteredWords thay vì allWords
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(3, 6),
                    blurRadius: 6,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 4),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: GoogleFonts.sen(fontSize: AppHeading.h5),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: englishWord.word != null
                                          ? englishWord.word![0]
                                          : "",
                                      style: GoogleFonts.sen(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          const BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(2, 4),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: englishWord.word != null
                                              ? englishWord.word!.substring(1)
                                              : "",
                                          style: GoogleFonts.sen(
                                            fontSize: AppHeading.h2,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              const BoxShadow(
                                                color: Colors.black38,
                                                offset: Offset(2, 4),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      flutterTts.speak("${englishWord.word}");
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(Icons.volume_up, color: Colors.white,),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '${englishWord.pronunciation}',
                                style: TextStyle(
                                  fontSize: AppHeading.h5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '“${englishWord.exampleSentence ?? "Think of all the beauty still left around you and be happy"}”',
                                style: GoogleFonts.sen(
                                  fontSize: AppHeading.h5,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Obx(() => Visibility(
            visible: _wordController.isFabVisible.value,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                _wordController.scrollToTop(); // Cuộn lên đầu trang
              },
              child: const Icon(Icons.arrow_upward),
            ),
          )),
    );
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  width: AppDimen.screenWidth,
                  constraints: const BoxConstraints(minHeight: 200),
                  decoration: const BoxDecoration(
                    color: AppColor.secondColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Topics: ",
                        style: GoogleFonts.sen(
                          fontSize: AppHeading.h3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        children: [
                          ...topics.map(
                            (item) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    topicSelected = item;
                                  });
                                },
                                child: Card(
                                  color: topicSelected == item
                                      ? AppColor.primaryColor
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item,
                                      style: GoogleFonts.sen(
                                        color: topicSelected == item
                                            ? Colors.white
                                            : AppColor.textColor,
                                        fontSize: AppHeading.h5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        "Word type: ",
                        style: GoogleFonts.sen(
                          fontSize: AppHeading.h3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        children: [
                          ...wordTypes.map(
                            (item) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    wordTypeSelected = item;
                                  });
                                },
                                child: Card(
                                  color: wordTypeSelected == item
                                      ? AppColor.primaryColor
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item,
                                      style: GoogleFonts.sen(
                                        color: wordTypeSelected == item
                                            ? Colors.white
                                            : AppColor.textColor,
                                        fontSize: AppHeading.h5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  topicSelected = "";
                                  wordTypeSelected = "";
                                });
                                _wordController.topicSelected.value =
                                    topicSelected;
                                _wordController.wordTypeSelected.value =
                                    wordTypeSelected;
                                // Gọi hàm fetchAllWords để tải lại dữ liệu mới sau khi xóa bộ lọc
                                _wordController.fetchAllWords(
                                    _wordController.page.value,
                                    20,
                                    topicSelected,
                                    wordTypeSelected);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Clear',
                                  style: GoogleFonts.sen(
                                    fontSize: AppHeading.h5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _wordController.topicSelected.value =
                                    topicSelected;
                                _wordController.wordTypeSelected.value =
                                    wordTypeSelected;
                                _wordController.fetchAllWords(
                                    _wordController.page.value,
                                    20,
                                    topicSelected,
                                    wordTypeSelected);
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: GoogleFonts.sen(
                                  fontSize: AppHeading.h5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
