import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/list/model.dart';
import 'package:hello_flutter/list/list_bloc.dart';

import '../backend/test_data_provider.dart';

void main() {
  test('Items are alphabetised, ignoring case', () async {
    final listBloc = ListBloc();
    listBloc.dataProviderForTest = TestDataProvider();

    listBloc.loadItems();

    final events = await listBloc.outItems.take(1).toList();

    verifyTestData(events[0]);
  });

  test('Selecting an unselected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.dataProviderForTest = TestDataProvider();

    await listBloc.loadItems();
    listBloc.selectItem(itemIdAlpha1);

    final events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);

    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), shouldBeSelected: true);
    verifySelectedStatus(events[1].items.elementAt(1), shouldBeSelected: itemSelectedTrueAlpha3);
    verifySelectedStatus(events[1].items.elementAt(2), shouldBeSelected: itemSelectedFalseAlpha3);

  });

  test('Selecting a selected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.dataProviderForTest = TestDataProvider();

    await listBloc.loadItems();
    listBloc.selectItem(itemIdAlpha2);

    final events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), shouldBeSelected: itemSelectedFalseAlpha1);
    verifySelectedStatus(events[1].items.elementAt(1), shouldBeSelected: true);
    verifySelectedStatus(events[1].items.elementAt(2), shouldBeSelected: itemSelectedFalseAlpha3);

  });

  test('Unselecting a selected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.dataProviderForTest = TestDataProvider();

    await listBloc.loadItems();
    listBloc.deSelectItem(itemIdAlpha2);

    final events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), shouldBeSelected: itemSelectedFalseAlpha1);
    verifySelectedStatus(events[1].items.elementAt(1), shouldBeSelected: false);
    verifySelectedStatus(events[1].items.elementAt(2), shouldBeSelected: itemSelectedFalseAlpha3);

  });

  test('Unselecting an unselected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.dataProviderForTest = TestDataProvider();

    await listBloc.loadItems();
    listBloc.deSelectItem(itemIdAlpha1);

    final events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), shouldBeSelected: false);
    verifySelectedStatus(events[1].items.elementAt(1), shouldBeSelected: itemSelectedTrueAlpha3);
    verifySelectedStatus(events[1].items.elementAt(2), shouldBeSelected: itemSelectedFalseAlpha3);

  });

}

void verifyTestData(ListOfItems data) {
  verifyTestDataExceptSelected(data);
  verifySelectedStatus(data.items.elementAt(0), shouldBeSelected: itemSelectedFalseAlpha1);
  verifySelectedStatus(data.items.elementAt(1), shouldBeSelected: itemSelectedTrueAlpha3);
  verifySelectedStatus(data.items.elementAt(2), shouldBeSelected: itemSelectedFalseAlpha3);
}

void verifyTestDataExceptSelected(ListOfItems data) {
  expect(data.errorMessage, isNull);
  expect(data.items.length, equals(3));
  expect(data.items.elementAt(0).title, equals(itemTitleAlpha1));
  expect(data.items.elementAt(1).title, equals(itemTitleAlpha2));
  expect(data.items.elementAt(2).title, equals(itemTitleAlpha3));
  expect(data.items.elementAt(0).id, equals(itemIdAlpha1));
  expect(data.items.elementAt(1).id, equals(itemIdAlpha2));
  expect(data.items.elementAt(2).id, equals(itemIdAlpha3));
}

void verifySelectedStatus(Item data, {bool shouldBeSelected}) {
  expect(data.selected, equals(shouldBeSelected));
}