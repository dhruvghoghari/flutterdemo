import 'package:flutter/material.dart';
import 'package:flutterdemo/login/SplashScreen.dart';
import 'package:flutterdemo/productget/ViewCategory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/LoginScreen.dart';

void main() async{
  runApp(const MyApp());
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString("token","12345678");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ViewCategory(),
    );
  }
}
