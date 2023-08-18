import 'package:flutter/material.dart';
import 'package:music_app/home_screen.dart';
import 'package:music_app/splashscreen.dart';
import 'package:music_app/profilescreen.dart';
import 'package:music_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => HomeScreen(userName: 'User',),
          '/profile': (context) => ProfileScreen(userId: ''),
        });
  }
}
