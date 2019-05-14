import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> incrementCounter() async {
  String _barcode = '';
  _barcode = await FlutterBarcodeScanner.scanBarcode('', '', true);
  return _barcode;
}
