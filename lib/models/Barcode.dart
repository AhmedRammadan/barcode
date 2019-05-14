class Barcode {
  var count_id;
  var count_code;
  var location_id;
  var make_id;
  var model_id;
  var asset_id;
  var type_id;
  var asset_barcode;
  var qty;
  var entity_id;
  var msg;
  var quantity;
  var entity_idRes;
  var status_ind;
  var adjusted_ind;

  Barcode(
      {this.count_id,
      this.count_code,
      this.location_id,
      this.make_id,
      this.model_id,
      this.asset_id,
      this.type_id,
      this.asset_barcode,
      this.qty,
      this.entity_id});

  factory Barcode.FromJson(Map<String, dynamic> map) {
    return Barcode(
        entity_id: map['entity_id'],
        count_id: map['count_id'],
        qty: map['qty'],
        asset_barcode: map['asset_barcode'],
        asset_id: map['asset_name'],
        count_code: map['count_code'],
        location_id: map['location_name'],
        make_id: map['make_name'],
        model_id: map['model_name'],
        type_id: map['type_name']);
  }

  Barcode.Res(
      {this.msg,
      this.quantity,
      this.entity_idRes,
      this.status_ind,
      this.adjusted_ind});

  factory Barcode.formJsonRes(Map<String, dynamic> map) {
    return Barcode.Res(
      msg: map['msg'],
      quantity: map['quantity'],
      entity_idRes: map['entity_id'],
      status_ind: map['status_ind'],
      adjusted_ind: map['adjusted_ind'],
    );
  }

  factory Barcode.FromJsonBarcode(Map<String, dynamic> map) {

    return Barcode(
    count_id: map['count_id'],
    count_code: map['count_code'],
        location_id: map['location_name'],
        make_id: map['make_name'],
        model_id: map['model_name'],
        type_id: map['type_name'],
        asset_barcode: map['asset_barcode'],
        entity_id: map['entity_id'],
        qty: map['qty']);
  }

  static Map<String, dynamic> toMapPost(qty, count_id, asset_barcode) {
    return {
      'qty': qty,
      'count_id': count_id,
      'user_name': 'xxx',
      'asset_barcode': asset_barcode,
    };
  }

//  Map<String, dynamic> toMap() {
//    return {
//      'msg': this.msg,
//      'entity_id': this.entity_id,
//      'entity_code': this.entity_code,
//      'series_name': this.series_name,
//      'asset_name': this.asset_name,
//      'make_name': this.make_name,
//    };
//  }
}
