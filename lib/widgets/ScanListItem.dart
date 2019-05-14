import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:barcode/database/api.dart';
import 'package:barcode/models/Barcode.dart';
import 'package:barcode/models/Inventory.dart';

var Quantity = '';

class ScanListItem extends StatelessWidget {
  Barcode thisBarcode = Barcode(
    type_id: '',
    model_id: '',
    make_id: '',
    location_id: '',
    count_code: '',
    asset_id: '',
    asset_barcode: '',
    qty: '',
    count_id: '',
    entity_id: '',
  );

  ScanListItem({this.thisBarcode});

  item3(Barcode barcode, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.green,
        child: InkWell(
            onTap: () {
              onAlertAddQuantity(context);
            },
            child: Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    height: 150,
                    padding: EdgeInsets.only(left: 12.0),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 2.0, color: Colors.white24),
                      ),
                    ),
                    child: Image.asset('assets/ic_barcode2.png'),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          barcode.make_id != null ? barcode.make_id : '',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        barcode.make_id != null ? '${barcode.qty}' : '',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.linear_scale, color: Colors.yellowAccent),
                      Text(
                          barcode.location_id != null
                              ? barcode.location_id
                              : '',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_left,
                      color: Colors.white, size: 30.0)),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return item3(thisBarcode, context);
  }

  changeQty() async {
    //04567
    if (Quantity.isNotEmpty) {
      Barcode barcode = await Api.postBarcode(
          code: '01234', qty: Quantity, count_id: "${thisBarcode.count_id}");
      print('entity_id : ${barcode.entity_id}');
      //barcodes.add(barcode);
    } else {
      print('Quantity 5 : ' + 'isEmpty');
    }
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
                  Center(
                    child: Text(
                      "  تحديد عدد المنتج الجديدة",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    onSubmitted: (value) {
                      if (Quantity.isNotEmpty) {
                        changeQty();
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
                        changeQty();
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
}

Widget item(Barcode barcode, context) {
  return InkWell(
    onTap: () {
      print(barcode.location_id);
    },
    child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: EdgeInsets.all(5),
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                height: 150,
                padding: EdgeInsets.only(left: 12.0),
                decoration: new BoxDecoration(
                  border: new Border(
                    left: new BorderSide(width: 2.0, color: Colors.white24),
                  ),
                ),
                child: Image.asset('assets/ic_barcode2.png'),
              ),
              title: Text(
                barcode.entity_id != null ? barcode.entity_id : '',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.linear_scale, color: Colors.yellowAccent),
                  Text(barcode.location_id != null ? barcode.location_id : '',
                      style: TextStyle(color: Colors.white))
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_left,
                  color: Colors.white, size: 30.0)),
        )),
  );
}

Widget item2(Barcode barcode, context, height) {
  return InkWell(
    onTap: () {
      print(barcode.asset_barcode);
    },
    child: Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: height / 4,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: height / 7 / 3,
            ),
            ListTile(
              title: Text(barcode.entity_id),
            ),
          ],
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}
