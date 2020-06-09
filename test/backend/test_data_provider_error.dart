import 'package:hello_flutter/list/list_bloc.dart';
import 'package:hello_flutter/list/model.dart';

const String errorMessage = "This is an error message";

class TestDataProviderError implements ItemsDataProvider {
  @override
  Future<ListOfItems> loadItems() {
    return Future.value(ListOfItems(null, errorMessage));
  }
}