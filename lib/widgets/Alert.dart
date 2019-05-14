import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertApp {
  // The easiest way for creating RFlutter Alert
  _onBasicAlertPressed(context) {
    Alert(
            context: context,
            title: "RFLUTTER ALERT",
            desc: "Flutter is more awesome with RFlutter Alert.")
        .show();
  }

// Alert with single button.
  static onAlertButtonPressed(context, title, desc) {
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

// Alert with multiple and custom buttons
  onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "FLAT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GRADIENT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

// Advanced using of alerts
  _onAlertWithStylePressed(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

// Alert custom images
  static onAlertError(context) {
    Alert(
        context: context,
        title: "خطا",
        desc: "هذا العنصر مسجل من قبل",
        image: Image.asset("assets/error.png",height: 100,width: 100,),
        buttons: [
          DialogButton(
              child: Text('الغاء',style: TextStyle(fontSize: 20,color: Colors.white),),
              onPressed: () {
                Navigator.pop(context);
              })
        ]).show();
  }

  static String onAlertAddQuantity(context) {
    String Quantity = '1';
    Alert(
        context: context,
        title: "تحديد الكمية",
        content: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                Quantity = value;
              },
              keyboardType: TextInputType.number,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: Quantity,
                labelText: 'عدد المنتج',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              return Quantity;
            },
            child: Text(
              "تاكيد",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  static qty(qty) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('qty', qty);
  }

// Alert custom content
  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
