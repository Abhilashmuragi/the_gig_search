import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  final bool isActive;

  const SliderIndicator({required this.isActive, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: 30,
      margin: const EdgeInsets.only(right: 5),
      decoration:
          BoxDecoration(color: isActive ? Colors.black : const Color.fromRGBO(236, 236, 236, 100), borderRadius: BorderRadius.circular(5)),
    );
  }
}
