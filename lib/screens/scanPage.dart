import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode/database/api.dart';
import 'package:barcode/languages/homePageLang.dart';
import 'package:barcode/languages/selectLanguage.dart';
import 'package:barcode/models/Barcode.dart';
import 'package:barcode/models/Inventory.dart';
import 'package:barcode/widgets/Alert.dart';
import 'package:barcode/widgets/ScanListView.dart';
import 'package:barcode/widgets/barcodeScan.dart';

class ScanPageRoute extends CupertinoPageRoute {
  Inventory inventory;

  ScanPageRoute(this.inventory)
      : super(builder: (BuildContext context) => new ScanPage(inventory));

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new ScanPage(inventory),
    );
  }
}

class ScanPage extends StatefulWidget {
  Inventory inventory;

  ScanPage(this.inventory);

  @override
  _ScanPageState createState() => _ScanPageState(this.inventory);
}

class _ScanPageState extends State<ScanPage>
    with SingleTickerProviderStateMixin {
  Inventory inventory;
  StreamSubscription<ConnectivityResult> subscription;

  _ScanPageState(this.inventory);

  String Quantity = '';
  var _lang;
  AnimationController animationController;
  Animation<double> animatable;

  bool _isConnnection = true;
  bool LTR = true;
  List<Barcode> barcodes = List();
  List<String> codes = List();

  getAllBarcode() async {
    barcodes.clear();
    print('${inventory.count_id}');
    barcodes = await Api.getAllBarcode(inventory.count_id);
    setState(() {});
  }

  checkLang() async {
    _lang = await Selectlanguage.getLang();
    if (_lang == 'en') {
      LTR = true;
    } else {
      LTR = false;
    }
    setState(() {});
  }

  barcodeScan() async {
    Quantity = '';
    String code = await incrementCounter();
    if (code.isNotEmpty) {
      bool isExist = false;
      for (var i = 0; i < barcodes.length; i++) {
        if (barcodes[i].asset_barcode == code) {
          isExist = true;
          break;
        }
      }
      if (!isExist) {
         onAlertAddQuantity(context,code);
      } else {
        AlertApp.onAlertError(context);
      }
      setState(() {});
    }
  }

  sendBarcode(barcode) async {
    //04567
    if (Quantity.isNotEmpty) {
      await Api.postBarcode(
          code: barcode, qty: Quantity, count_id: "${inventory.count_id}");
      print('entity_id : ${barcode.entity_id}');
      getAllBarcode();
    } else {
      print('Quantity 5 : ' + 'isEmpty');
    }
  }

  onAlertAddQuantity(context,barcode) {
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
                  Center(
                    child: Text(
                      "تحديد عدد المنتج",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    onSubmitted: (value) {
                      if (Quantity.isNotEmpty) {
                        sendBarcode(barcode);
                        Navigator.pop(context);
                      } else {
                        print('Quantity 5 : ' + 'isEmpty');
                      }
                    },
                    onChanged: (value) {
                      Quantity = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'عدد المنتج',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DialogButton(
                    onPressed: () {
                      if (Quantity.isNotEmpty) {
                        sendBarcode(barcode);
                        Navigator.pop(context);
                      } else {
                        print('Quantity 5 : ' + 'isEmpty');
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

  @override
  void initState() {
    super.initState();
    checkLang();
    getAllBarcode();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      checkInternet(result);
    });
    animationController = AnimationController(
        duration: Duration(
          milliseconds: 1200,
        ),
        vsync: this);

    animatable = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    );
    animatable.addListener(() {
      setState(() {});
    });
    animatable.addStatusListener((status) {});
    animationController.repeat();

  }

  checkInternet(result) async {
    if (result == ConnectivityResult.wifi) {
      getAllBarcode();
      _isConnnection = true;
    } else {
      _isConnnection = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  Future<Null> reRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    await getAllBarcode();
    return null;
  }

  notConnection() {
    return InkWell(
      onTap: () {},
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.wifi_lock,
              color: Colors.green,
              size: 100,
            ),
            Text('لا يوجد اتصال بالانترنت')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: !LTR ? null : null,
      drawer: LTR ? null : null,
      appBar: AppBar(
        centerTitle: true,
        title: Text(_lang == 'en'
            ? HomePageLangEn.en_titleAppBar
            : HomePageLangAr.ar_titleAppBar),
      ),
      body: _isConnnection
          ? RefreshIndicator(
              child: ScanListView(
                barcodes: barcodes,
              ),
              onRefresh: reRefresh,
            )
          : notConnection(),
      floatingActionButton:_isConnnection? Container(
        height: animatable.value * 60,
        child: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: barcodeScan,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/ic_barcode.png'),
          ),
        ),
      ):Container(),
    );
  }
}
/*
Container(
margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
alignment: !LTR ? Alignment.centerRight : Alignment.centerLeft,
height: animatable.value * 60,
child: FloatingActionButton(
backgroundColor: Colors.greenAccent,
onPressed: barcodeScan,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Image.asset('assets/ic_barcode.png'),
),
),
),*/
