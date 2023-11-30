import 'package:flutter/material.dart';
import 'package:flutterdemo/login/HomeScreen.dart';
import 'package:flutterdemo/login/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  logindata() async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
    {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    else
    {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginScreen())
      );
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds:3),(){
      setState(() {
        logindata();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SplashScreen"),),
      body: SafeArea(
        child: Column(
          children: [
            Text("Welcome To SPlashSCreen")
          ],
        ),
      ),
    );
  }
}
