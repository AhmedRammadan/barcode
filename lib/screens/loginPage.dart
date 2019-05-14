import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:barcode/database/api.dart';
import 'package:barcode/database/login.dart';
import 'package:barcode/widgets/Alert.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontSize: 20.0);
  var username = '';
  var Ip = '';
  var ipError = '';
  var password = '';
  bool passowrdHiden = true;
  bool progress = false;
  bool hasError= false;
  bool _isConnnection = true;
  StreamSubscription<ConnectivityResult> subscription;

  login() async {
    if (username.isNotEmpty && password.isNotEmpty) {
      bool isLogin = await Api.setLogin(userName: username, password: password);
      progress = false;
      setState(() {});
      if (isLogin) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        progress = true;
        Login.setLogin();
      } else {
        progress = false;
        AlertApp.onAlertButtonPressed(context, 'حدث خطا فى تسجيل الدخول',
            'تاكد من اسم المستخدم او كلمة المرور او ip');
      }
    }else{
      print('cleck................');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Login.setIp('');
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      checkInternet(result);
    });
  }

  checkInternet(result) async {
    if (result == ConnectivityResult.wifi) {
      _isConnnection = true;
    } else {
      _isConnnection = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userNamField = TextField(
      onChanged: (value) {
        username = value;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "اسم الستخدم",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final passwordField = TextField(
      onChanged: (value) {
        password = value;
      },
      obscureText: passowrdHiden,
      style: style,
      decoration: InputDecoration(
          suffixIcon: passowrdHiden
              ? InkWell(
                  onTap: () {
                    if (passowrdHiden) {
                      passowrdHiden = false;
                    } else {
                      passowrdHiden = true;
                    }
                    setState(() {});
                  },
                  child: Icon(Icons.visibility_off),
                )
              : InkWell(
                  onTap: () {
                    if (passowrdHiden) {
                      passowrdHiden = false;
                    } else {
                      passowrdHiden = true;
                    }
                    setState(() {});
                  },
                  child: Icon(
                    Icons.visibility,
                    color: Colors.green,
                  ),
                ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "كلمة المرور",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
      child: MaterialButton(
        height: 10,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          _isConnnection
              ? login()
              : AlertApp.onAlertButtonPressed(context,
                  'حدث خطا فى تسجيل الدخول', 'تاكد من الاتصال بالانترنت');
        },
        child: Text("تسجيل الدخول",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Stack(
              children: <Widget>[
                Center(child: progress ? CircularProgressIndicator() : null),
                ListView(
                  children: <Widget>[
                    /*  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),*/
                    SizedBox(
                      height: 155.0,
                      child: Icon(
                        Icons.person,
                        color: Colors.green,
                        size: 150,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    userNamField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButton,
                    SizedBox(
                      height: 35.0,
                    ),
                    InkWell(
                      onTap: () {
                        onAlertAddQuantity(context);                        //Login.setIp('');
                      },
                      child: Center(
                        child: Text(
                          'تسجيل ip',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onAlertAddQuantity(context) {
    showDialog(
      barrierDismissible: false, // JUST MENTION THIS LINE
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Padding(
          padding: const EdgeInsets.only(
              right: 20.0, left: 20.0, top: 10, bottom: 10),
          child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  TextField(
                    onSubmitted: (value) {
                      if (Ip.isNotEmpty) {
                        Login.setIp(Ip);
                        Ip = '';
                        Navigator.pop(context);
                      } else {
                        hasError = true;
                        ipError = 'مطلوب ادخال ip';
                        setState(() {

                        });
                      }
                    },
                    onChanged: (value) {
                      Ip = value;
                      if (Ip.isNotEmpty) {
                        hasError = false;
                      } else {
                        hasError = true;
                        ipError = 'مطلوب ادخال ip';

                      }
                      setState(() {

                      });
                    },
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                    errorText:hasError?ipError:null ,
                      labelText: 'ادخل ip',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DialogButton(
                    onPressed: () {
                      if (Ip.isNotEmpty) {
                        Login.setIp(Ip);
                        Ip = '';
                        Navigator.pop(context);
                      } else {
                        hasError = true;
                        ipError = 'مطلوب ادخال ip';
                        setState(() {

                        });
                      }
                    },
                    child: Text(
                      "تاكيد",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              )),
        ));
      },
    );
  }
}
