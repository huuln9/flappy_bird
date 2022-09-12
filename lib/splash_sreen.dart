import 'package:flappy_bird/app.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/bird.png"),
          const Text(
            "C O N  C H I M  H U  H O N G",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          TextButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const App()));
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text("P L A Y"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.redAccent.shade700,
              padding: const EdgeInsets.all(15),
              shadowColor: Colors.black,
              elevation: 10,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
          // const Text(
          //   "game ngu n` hon tai huusumo.com",
          //   style: TextStyle(color: Colors.white),
          // ),
        ],
      ),
    );
  }
}
