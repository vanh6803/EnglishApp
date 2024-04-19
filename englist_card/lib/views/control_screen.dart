import 'package:englist_card/constants/app_assets.dart';
import 'package:englist_card/constants/app_color.dart';
import 'package:englist_card/constants/app_heading.dart';
import 'package:englist_card/controllers/word_controller.dart';
import 'package:englist_card/utils/app_cache_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final WordController _wordController = Get.put(WordController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double sliderValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    String? cachedValue = await AppCacheData.getCounterToCache();
    if (cachedValue != null) {
      int value = int.tryParse(cachedValue) ?? _wordController.limit.value;
      setState(() {
        sliderValue = value.toDouble();
      });
    } else {
      setState(() {
        sliderValue = _wordController.limit.value.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,
        elevation: 0,
        leading: InkWell(
          onTap: () async {
            await AppCacheData.setCounterToCache("$sliderValue");
            _wordController.limit.value = sliderValue.toInt();
            await _wordController.wordToday(_wordController.limit.value);
            Get.back();
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
        title: Text(
          'Your control',
          style: GoogleFonts.sen(color: AppColor.textColor, fontSize: 36),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Text(
            'How much a number word at once',
            style: GoogleFonts.sen(
                color: AppColor.lightGrey, fontSize: AppHeading.h3),
          ),
          const Spacer(),
          Text(
            '${sliderValue.toInt()}',
            style: GoogleFonts.sen(
                color: AppColor.primaryColor,
                fontSize: 150,
                fontWeight: FontWeight.bold),
          ),
          Slider(
              value: sliderValue,
              min: 5,
              max: 100,
              divisions: 95,
              activeColor: AppColor.primaryColor,
              inactiveColor: AppColor.primaryColor,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              }),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.centerLeft,
            child: Text(
              'slide to set',
              style: GoogleFonts.sen(color: AppColor.textColor),
            ),
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}
