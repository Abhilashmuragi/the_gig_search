import 'package:flutter/material.dart';
import 'package:the_gig_workers_app/utils/values/colors.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  final double? fontSize;

  const CustomFormButton({Key? key, required this.innerText, required this.onPressed, this.fontSize = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: ColorSys.authSubmit,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
