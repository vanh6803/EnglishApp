import 'package:englist_card/constants/app_color.dart';
import 'package:englist_card/constants/app_heading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonOption extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const ButtonOption({super.key, required this.label, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(3, 6),
              blurRadius: 3,
            )
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon,
            ),
            Text(
              label,
              style: GoogleFonts.sen(
                  color: AppColor.textColor,
                  fontSize: AppHeading.h5,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
