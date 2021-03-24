import 'package:flutter/material.dart';
import 'package:foodhot/pages/HomePage.dart';
import 'package:foodhot/pages/RegisterPage.dart';
import 'package:foodhot/pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: '/',
    
    routes: {
      '/': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
      '/home': (context) => HomePage(),
    },
  ));
}
