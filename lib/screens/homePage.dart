import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode/database/login.dart';
import 'package:barcode/languages/homePageLang.dart';
import 'package:barcode/languages/selectLanguage.dart';
import 'package:barcode/models/Inventory.dart';
import 'package:barcode/database/api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:barcode/widgets/InventoryListView.dart';

import 'loginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'تسجيل خروج'),
];

class _HomePageState extends State<HomePage> {
  var _lang;
  bool LTR = true;
  bool isProgress = true;
  List<Inventory> inventories = List();
  var test = '';
  bool _isConnnection = true;
  StreamSubscription<ConnectivityResult> subscription;

  checkInternet(result) async {
    if (result == ConnectivityResult.wifi) {
      getInventories();
      _isConnnection = true;
    } else {
      _isConnnection = false;
    }
    setState(() {});
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

  checkLang() async {
    await Selectlanguage.setLang('ar');
    _lang = await Selectlanguage.getLang();
    if (_lang == 'en') {
      LTR = true;
    } else {
      LTR = false;
    }
    setState(() {});
  }

  getInventories() async {
    inventories.clear();
    inventories = await Api.getData();
    isProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkLang();
    getInventories();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      checkInternet(result);
    });
  }

  CustomPopupMenu _selectedChoices = choices[0];

  void _select(CustomPopupMenu choice) async {
    await Login.setLogout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    setState(() {
      _selectedChoices = choice;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  Future<Null> reRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    await getInventories();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: !LTR ? null : null,
      drawer: LTR ? null : null,
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<CustomPopupMenu>(
            elevation: 3.2,
            initialValue: _selectedChoices,
            onCanceled: () {
              print('You have not chossed anything');
            },
            tooltip: 'قائمة',
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((CustomPopupMenu choice) {
                return PopupMenuItem<CustomPopupMenu>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
        centerTitle: true,
        title: Text(_lang == 'en'
            ? HomePageLangEn.en_titleAppBar
            : HomePageLangAr.ar_titleAppBar),
      ),
      body: _isConnnection
          ? RefreshIndicator(
              // key if you want to add
              onRefresh: reRefresh, // refresh callback
              child: Center(
                child: isProgress
                    ? CircularProgressIndicator()
                    : InventoryListView(
                        inventories: inventories,
                      ),
              ), // scroll view
            )
          : notConnection(),
    );
  }
}

/*Center(
child: isProgress
? CircularProgressIndicator()
    : InventoryListView(
inventories: inventories,
),
)*/
class CustomPopupMenu {
  CustomPopupMenu({this.title});

  String title;
}
