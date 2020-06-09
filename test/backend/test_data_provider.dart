import 'package:hello_flutter/list/model.dart';
import 'package:hello_flutter/list/list_bloc.dart';

const String itemTitleAlpha1 = "an item";
const String itemTitleAlpha2 = "Before";
const String itemTitleAlpha3 = "last";
const int itemIdAlpha1 = 2;
const int itemIdAlpha2 = 1;
const int itemIdAlpha3 = 3;
const bool itemSelectedFalseAlpha1 = false;
const bool itemSelectedTrueAlpha3 = true;
const bool itemSelectedFalseAlpha3 = false;

class TestDataProvider implements ItemsDataProvider {
  @override
  Future<ListOfItems> loadItems() {
    final List<Item> list = [];
    list.add(Item(itemIdAlpha2, itemTitleAlpha2, "", selected: itemSelectedTrueAlpha3));
    list.add(Item(itemIdAlpha1, itemTitleAlpha1, "", selected: itemSelectedFalseAlpha1));
    list.add(Item(itemIdAlpha3, itemTitleAlpha3, "", selected: itemSelectedFalseAlpha3));
    return Future.value(ListOfItems(list, null));
  }
}