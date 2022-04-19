import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monprof/UI/login.dart';
import 'package:monprof/UI/onboardinding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monprof/UI/splashscreen.dart';
import 'package:monprof/UI/transition.dart';
// import 'package:monprof/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TransitionPage(),
    );
  }
}
