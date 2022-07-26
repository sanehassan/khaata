import 'package:flutter/material.dart';

import 'history.dart';
import 'landingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LandingScreen(),
        '/history': (context) => History(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
