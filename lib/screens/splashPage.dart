import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:barcode/database/login.dart';
import 'package:barcode/screens/homePage.dart';
import 'loginPage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLogin = false;

  isLogin() async {
    bool login = false;
    login = await Login.isLogin();
    if (login != false && login != true) {
      _isLogin = false;
    }else{
      _isLogin = login;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: _isLogin ? HomePage() : LoginPage(),
      image: Image.asset('assets/ic_barcode.png'),
      backgroundColor: Colors.green.withOpacity(0.8),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.greenAccent,
      onClick: () => print("Flutter Egypt"),
    );
  }
}
