import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:hello_flutter/backend/backend_data.dart';
import 'package:hello_flutter/list/model.dart';

class ListBloc {
  static final ListBloc _singleton = ListBloc._internal();

  factory ListBloc() {
    return _singleton;
  }

  ListBloc._internal();

  ItemsDataProvider provider = BackendData();

  set dataProviderForTest(ItemsDataProvider provider) {
    this.provider = provider;
  }

  ItemsDataProvider get dataProviderForTest {
    return provider;
  }

  final BehaviorSubject<ListOfItems> _itemsController = BehaviorSubject<ListOfItems>();
  Stream<ListOfItems> get outItems => _itemsController.stream;

  Future loadItems() async {
    final ListOfItems items = await provider.loadItems();
    if (items.items != null) {
      items.items.sort(_alphabetiseItemsByTitleIgnoreCases);
    }
    _itemsController.sink.add(items);
  }

  int _alphabetiseItemsByTitleIgnoreCases(Item a, Item b) {
    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  }

  void selectItem(int id) {
    StreamSubscription subscription;
    subscription = ListBloc().outItems.listen((listOfItems) async {
      final List<Item> newList = [];
      for (final item in listOfItems.items){
        if (item.id == id) {
          newList.add(Item(item.id, item.title, item.description, selected: true));
        } else {
          newList.add(item);
        }
      }
      _itemsController.sink.add(ListOfItems(newList, null));
      subscription.cancel();
    });
  }

  void deSelectItem(int id) {
    StreamSubscription subscription;
    subscription = ListBloc().outItems.listen((listOfItems) async {
      final List<Item> newList = [];
      for (final item in listOfItems.items){
        if (item.id == id) {
          newList.add(Item(item.id, item.title, item.description, selected: false));
        } else {
          newList.add(item);
        }
      }
      _itemsController.sink.add(ListOfItems(newList, null));
      subscription.cancel();
    });
  }

  void dispose() {
    _itemsController.close();
  }
}

abstract class ItemsDataProvider {
  Future<ListOfItems> loadItems();
}
