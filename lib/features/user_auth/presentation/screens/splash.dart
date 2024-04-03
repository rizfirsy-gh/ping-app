import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ping!'),
      ),
      body: Center(
        child: Container(
          margin:
              const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
          width: 200,
          child: Image.asset('lib/assets/images/ping_logo.png'),
        ),
      ),
    );
  }
}
