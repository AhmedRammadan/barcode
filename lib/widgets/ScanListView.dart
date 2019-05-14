import 'package:flutter/material.dart';
import 'package:barcode/models/Barcode.dart';
import 'ScanListItem.dart';
class ScanListView extends StatelessWidget {
  List<Barcode> barcodes;
  ScanListView({this.barcodes});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: barcodes.map((value) =>  ScanListItem(thisBarcode: value)).toList(),
    );
  }
}
