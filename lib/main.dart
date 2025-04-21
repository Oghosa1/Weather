<<<<<<< HEAD
import 'package:flutter/material.dart';
=======

import 'package:flutter/material.dart';

>>>>>>> 2acdb10 (sdk update)
import 'screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
