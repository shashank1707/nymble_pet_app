import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DancingCat extends StatelessWidget {
  const DancingCat({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        const url = "https://www.linkedin.com/in/kumar-shashank-546b2a1a4/";
        if (!await launchUrlString(url)) {
          throw 'Could not launch $url';
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Lottie.asset(
          'assets/images/lottie_dancing_cat.json',
        ),
      ),
    );
  }
}
