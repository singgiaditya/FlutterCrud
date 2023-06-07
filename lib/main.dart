import 'package:crud/create.dart';
import 'package:crud/editData.dart';
import 'package:crud/onBoarding.dart';
import 'package:crud/read.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image(image: AssetImage("images/SINGGI.jpg" )),
      backgroundColor: Colors.white,
      showLoader: false,
      navigator: onBoarding(),
      durationInSeconds: 5,
    );
  }
}