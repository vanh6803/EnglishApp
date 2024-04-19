import 'package:englist_card/components/button_option.dart';
import 'package:englist_card/constants/app_assets.dart';
import 'package:englist_card/constants/app_color.dart';
import 'package:englist_card/constants/app_dimen.dart';
import 'package:englist_card/constants/app_heading.dart';
import 'package:englist_card/controllers/quote_controller.dart';
import 'package:englist_card/controllers/word_controller.dart';
import 'package:englist_card/models/word.dart';
import 'package:englist_card/views/all_word_screen.dart';
import 'package:englist_card/views/control_screen.dart';
import 'package:englist_card/views/favorite_screem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final WordController _wordController = Get.put(WordController());
  final QuoteController _quoteController = Get.put(QuoteController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterTts flutterTts = FlutterTts();

  List<String> abbreviationForWordType = [
    "N",
    "V",
    "Adj",
    "Adv",
    "Pron",
    "Prep",
    "Conj",
    "Interj"
  ];

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('en-US');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
        title: Text(
          'English to day',
          style: GoogleFonts.sen(
            color: AppColor.textColor,
            fontSize: AppHeading.h1,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColor.lighBlue,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 16),
                child: Text(
                  'Your mind',
                  style: GoogleFonts.sen(
                    color: AppColor.textColor,
                    fontSize: AppHeading.h1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 24.0),
              //   child: ButtonOption(
              //     icon: const Icon(
              //       Icons.favorite_border,
              //     ),
              //     label: 'Favorites',
              //     onTap: () {
              //       Get.to(() => const FavoriteScreen());
              //       _scaffoldKey.currentState?.closeDrawer();
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ButtonOption(
                  icon: const Icon(Icons.control_camera_outlined),
                  label: 'Your Control',
                  onTap: () {
                    Get.to(() => const ControlScreen());
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 24.0),
              //   child: ButtonOption(
              //     icon: const Icon(Icons.auto_stories_outlined),
              //     label: 'Stories',
              //     onTap: () {
              //       Get.to(() => const StoriesScreen());
              //       _scaffoldKey.currentState?.closeDrawer();
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ButtonOption(
                  icon: const Icon(Icons.clear_all_rounded),
                  label: 'All word',
                  onTap: () {
                    Get.to(() => const AllWordScreen());
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _wordController.wordToday(_wordController.limit.value);
        },
        backgroundColor: AppColor.primaryColor,
        shape: const CircleBorder(),
        child: Image.asset(AppAssets.exchange),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.centerLeft,
                height: AppDimen.screenHeight * 1 / 10,
                child: Text(
                  '“${_quoteController.quote.value?.quote}” - ${_quoteController.quote.value?.author}',
                  style: GoogleFonts.sen(
                    color: AppColor.textColor,
                    fontSize: AppHeading.h6,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppDimen.screenHeight * 0.7,
              child: Obx(
                () => _wordController.words.isEmpty
                    ? Container(
                        color: AppColor.primaryColor,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                    : CardSwiper(
                        numberOfCardsDisplayed: 3,
                        isLoop: true,
                        cardsCount: _wordController.words.length,
                        cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) {
                          EnglishWord word = _wordController.words[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: AppColor.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3, 6),
                                    blurRadius: 6,
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          '${index + 1}',
                                          style: GoogleFonts.sen(
                                            fontWeight: FontWeight.w500,
                                            fontSize: AppHeading.h5,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          AppAssets.heart,
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: word.word != null
                                          ? word.word![0]
                                          : "",
                                      style: GoogleFonts.sen(
                                        fontSize: 89,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          const BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(3, 6),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: word.word != null
                                              ? word.word!.substring(1)
                                              : "",
                                          style: GoogleFonts.sen(
                                            fontSize: 42,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              const BoxShadow(
                                                color: Colors.black38,
                                                offset: Offset(3, 6),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("${word.wordType}"),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Text(
                                          '${word.pronunciation}',
                                          style: TextStyle(
                                            fontSize: AppHeading.h3,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          flutterTts.speak('${word.word}');
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                          ),
                                          child: Icon(
                                            Icons.volume_up_outlined,
                                            size: 40,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: GestureDetector(
                                            onTap: () {
                                              flutterTts.speak(
                                                  '${word.exampleSentence}');
                                            },
                                            child: const Icon(
                                              Icons.volume_up_rounded,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'Example: “${word.exampleSentence ?? "Think of all the beauty still left around you and be happy"}”',
                                          style: GoogleFonts.sen(
                                            fontSize: AppHeading.h2,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
