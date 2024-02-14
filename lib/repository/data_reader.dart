import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DataReader {
  static final DataReader _singleton = DataReader._internal();

  factory DataReader() {
    return _singleton;
  }

  DataReader._internal();

  static Future getJson() async {
    String data = await rootBundle.loadString('assets/data/data.json');
    return json.decode(data) as Map;
  }
}
