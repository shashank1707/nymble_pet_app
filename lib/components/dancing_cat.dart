import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DancingCat extends StatelessWidget {
  const DancingCat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Lottie.asset(
        'assets/images/lottie_dancing_cat.json',
      ),
    );
  }
}
