import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            BirdHead(),
            // Positioned(
            //   bottom: 10,
            //   left: 10,
            //   child: BirdBody(),
            // ),
          ],
        ),
      ),
    );
    // return SizedBox(
    //   width: 100,
    //   height: 100,
    //   child: Image.asset("assets/images/bird.png"),
    // );
  }
}

class BirdHead extends StatelessWidget {
  const BirdHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset("assets/images/thui.png"),
    );
  }
}

class BirdBody extends StatelessWidget {
  const BirdBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Image.asset("assets/images/huy_oc_cho_minh.png"),
    );
  }
}
