class Inventory {
  var count_id;
  var count_code;
  var location_id;
  var make_id;
  var model_id;
  var asset_id;
  var type_id;

  Inventory(
      {this.count_id,
      this.count_code,
      this.location_id,
      this.make_id,
      this.model_id,
      this.asset_id,
      this.type_id});

  factory Inventory.FromJson(Map<String, dynamic> map) {
    return Inventory(
        count_id: map['count_id'],
        count_code: map['count_id'],
        location_id: map['location_name'],
        make_id: map['make_name'],
        model_id: map['model_name'],
        asset_id: map['asset_name'],
        type_id: map['type_name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'count_id': this.count_id,
      'count_code': this.count_code,
      'location_id': this.location_id,
      'make_id': this.make_id,
      'model_id': this.model_id,
      'asset_id': this.asset_id,
      'type_id': this.type_id
    };
  }
}
