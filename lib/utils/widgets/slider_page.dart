import 'package:flutter/material.dart';

class SliderPage extends StatelessWidget {
  final String image, title, content;

  const SliderPage({required this.image, required this.title, required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[Image.asset(image, fit: BoxFit.fitHeight), const SizedBox(height: 60)]),
          Text(title, style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          Text(content, style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400)),
          const SizedBox(),
        ],
      ),
    );
  }
}
