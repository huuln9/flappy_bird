import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Barrier extends StatelessWidget {
  double size;

  Barrier({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(width: 10, color: Colors.green.shade800),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
