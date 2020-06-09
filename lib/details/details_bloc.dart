import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:hello_flutter/list/model.dart';
import 'package:hello_flutter/list/list_bloc.dart';

class DetailsBloc {
  static final DetailsBloc _singleton = DetailsBloc._internal();

  factory DetailsBloc() {
    return _singleton;
  }

  DetailsBloc._internal();

  final BehaviorSubject<Item> _itemController = BehaviorSubject<Item>();
  Stream<Item> get outItem => _itemController.stream;
  StreamSubscription _subscription;
  int _currentId;

  Future<void> getItem(int id) async {
    // Reset the item
    _itemController.sink.add(null);

    _currentId = id;
    if (_subscription != null) {
      _subscription.cancel();
    }

    _subscription = ListBloc().outItems.listen((listOfItems) async {
      for (final item in listOfItems.items){
        if (item.id == _currentId) {
          _itemController.sink.add(item);
          break;
        }
      }
    });
  }

  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }
    _itemController.close();
  }
}