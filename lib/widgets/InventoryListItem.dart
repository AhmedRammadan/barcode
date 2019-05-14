import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:barcode/models/Inventory.dart';
import 'package:barcode/screens/scanPage.dart';

class InventoryListItem extends StatelessWidget {
  Inventory inventory;

  InventoryListItem({this.inventory});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return item3(inventory, context);
  }
}

Widget item(Inventory inventory, context) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ScanPage(inventory)));
      print(inventory.count_code);
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
                        left:
                            new BorderSide(width: 2.0, color: Colors.white24))),
                child: Image.asset('assets/list.png'),
              ),
              title: Text(
                inventory.asset_id,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.linear_scale, color: Colors.yellowAccent),
                  Text(inventory.location_id,
                      style: TextStyle(color: Colors.white))
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_left,
                  color: Colors.white, size: 30.0)),
        )),
  );
}

Widget item2(context, inventory, height, width) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
    child: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ScanPage(inventory)));
        print(inventory.count_code);
      },
      child: Container(
        height: height / 4,
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(inventory.location_id, style: TextStyle(fontSize: 20)),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'الوقع',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                width: width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(inventory.type_id),
                              Text('النوع'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(inventory.make_id),
                              Text('يصنع'),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, bottom: 5, top: 5, right: 20),
                      height: height / 7 / 1,
                      width: 2,
                      color: Colors.black.withOpacity(.5),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(inventory.asset_id),
                              Text('الاصل'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(inventory.model_id),
                              Text('النموذج'),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
//        يصنع
//        نموذج
//        الأصول
//        نوع
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}

item3(Inventory inventory, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
        color: Colors.green,
      child:  InkWell(
        onTap: () {
          Navigator.of(context).push( ScanPageRoute(inventory));
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) => ScanPageRoute(inventory)));
          print(inventory.count_code);
        },
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
                        left:
                        new BorderSide(width: 2.0, color: Colors.white24))),
                child: Image.asset('assets/list.png'),
              ),
              title: Text(
                inventory.make_id,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.linear_scale, color: Colors.yellowAccent),
                  Text(inventory.location_id,
                      style: TextStyle(color: Colors.white))
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_left,
                  color: Colors.white, size: 30.0)),
        )
      ),
    ),
  );
}
