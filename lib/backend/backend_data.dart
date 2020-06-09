import 'dart:async';
import 'dart:convert';
import 'package:hello_flutter/list/model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hello_flutter/list/list_bloc.dart';

/// Mock backend, and load the data from the json file
class BackendData implements ItemsDataProvider {
  static final BackendData _singleton = BackendData._internal();

  factory BackendData() {
    return _singleton;
  }

  BackendData._internal();

  @override
  Future<ListOfItems> loadItems() async {
    try {
      final bundle = await rootBundle.loadString('assets/data.json');
      final items = json.decode(bundle)['items'] as List;
      final parsed = List<Map<String, dynamic>>.from(items);
      final list = parsed.map((json) => Item.fromJson(json)).toList();
      return ListOfItems(list, null);
    } catch (exception) {
      return ListOfItems(null, exception.toString());
    }
  }
}