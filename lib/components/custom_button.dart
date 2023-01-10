import 'package:flutter/material.dart';
import 'package:nymble_pet_app/constants.dart';

class CustomButton extends StatelessWidget {
  final double width, height;
  final void Function() onPressed;
  final String title;
  final bool disabled;
  const CustomButton(
      {required this.title,
      required this.width,
      required this.height,
      required this.onPressed,
      required this.disabled,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: disabled ? Colors.grey : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30)),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: buttonTextColor),
        )),
      ),
    );
  }
}
