import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode/screens/splashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        return new Directionality(
          textDirection: TextDirection.rtl,
          child: new Builder(
            builder: (BuildContext context) {
              return new MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: child,
              );
            },
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'barcode',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashPage(),
      //  home: login ? HomePage() : LoginPage(),
    );
  }
}
