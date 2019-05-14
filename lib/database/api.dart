import 'package:http/http.dart' as http;
import 'package:barcode/models/Barcode.dart';
import 'dart:convert';

import 'package:barcode/models/Inventory.dart';

import 'login.dart';

class Api {
  static getIp() async {
    ip = await Login.getIp();
    if (ip == null || ip.length < 11) {
      hasIp = false;
      await Login.setLogout();
    } else {
      hasIp = true;
    }
   // hasIp = true;
   // ip ='192.168.1.14';
  }

  static String ip;

  static bool hasIp;

  static final url = 'http://$ip:8080/ords/sitapi/';

  static Future<bool> setLogin({userName, password}) async {
    await getIp();
    if (hasIp) {
      http.Response response = await http.post(
        url + 'login/auth',
        body: {
          "user_name": userName,
          "password": password,
        },
      );
      var responseUtf8 = utf8.decode(response.bodyBytes);
      Map data = json.decode(responseUtf8);
      if (data['status'] == "True") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<List<Inventory>> getData() async {
    await getIp();

    List<Inventory> inventories = List();
    if (hasIp) {
      http.Response response = await http.get(
        url + 'entity/data',
      );
      var responseUtf8 = utf8.decode(response.bodyBytes);
      Map data = json.decode(responseUtf8);
      var items = data['items'];
      for (var item in items) {
        Inventory inventory = Inventory.FromJson(item);
        inventories.add(inventory);
      }
      print(inventories[0].count_code);
      return inventories;
    } else {
      return inventories;
    }
  }

  static Future<Barcode> postBarcode({qty, count_id, code}) async {
    await getIp();
    Barcode barcode = Barcode();
    if (hasIp) {
      http.Response response = await http.post(url + 'counts/add',
          body: Barcode.toMapPost(qty, count_id, code));
      var responseUtf8 = utf8.decode(response.bodyBytes);
      Map data = json.decode(responseUtf8);
      barcode = Barcode.formJsonRes(data);
      return barcode;
    } else {
      return barcode;
    }
  }

  static Future<List<Barcode>> getAllBarcode(count_id) async {
    await getIp();
    if (hasIp) {
      List<Barcode> barcodes = List();
      http.Response response = await http.get(
        url + 'counts/qry/$count_id',
      );
      var responseUtf8 = utf8.decode(response.bodyBytes);
      Map data = json.decode(responseUtf8);
      //print(data.toString());
      var items = data['items'];
      for (var item in items) {
        Barcode barcode = Barcode.FromJsonBarcode(item);
        barcodes.add(barcode);
      }
      print(barcodes[0].location_id);
      return barcodes;
    } else {
      return null;
    }
  }
}
