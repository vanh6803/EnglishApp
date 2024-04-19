import 'package:englist_card/constants/app_assets.dart';
import 'package:englist_card/constants/app_color.dart';
import 'package:englist_card/constants/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
          'Your favorite',
          style: GoogleFonts.sen(color: AppColor.textColor, fontSize: 36),
        ),
      ),
    );
  }
}
