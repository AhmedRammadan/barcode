import 'package:flutter/material.dart';
import 'package:barcode/models/Inventory.dart';

import 'InventoryListItem.dart';
class InventoryListView extends StatelessWidget {
  List<Inventory> inventories = List();
  InventoryListView({this.inventories});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: inventories.map((value) =>  InventoryListItem(inventory: value)).toList(),
    );
  }
}
