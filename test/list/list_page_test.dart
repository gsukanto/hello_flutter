import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/list/list_bloc.dart';
import 'package:hello_flutter/list/list_page.dart';

import '../backend/test_data_provider.dart';
import '../backend/test_data_provider_error.dart';

void main() {

  testWidgets('Items are displayed', (WidgetTester tester) async {
    // Inject data provider
    ListBloc().dataProviderForTest = TestDataProvider();

    // Build widget
    await tester.pumpWidget(const ListPageWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final item1Finder = find.text(itemTitleAlpha1);
    final item2Finder = find.text(itemTitleAlpha2);
    final item3Finder = find.text(itemTitleAlpha3);
    expect(item1Finder, findsOneWidget);
    expect(item2Finder, findsOneWidget);
    expect(item3Finder, findsOneWidget);

    bool widgetSelectedPredicate(Widget widget) {
      return widget is Container && widget.color == Colors.green.shade200;
    }
    bool widgetUnselectedPredicate(Widget widget) {
      return widget is Container && widget.color == Colors.white;
    }

    expect(find.byWidgetPredicate(widgetSelectedPredicate), findsOneWidget);
    expect(find.byWidgetPredicate(widgetUnselectedPredicate), findsNWidgets(2));
  });

  testWidgets('Error message is displayed when server error', (WidgetTester tester) async {
    // Inject data provider
    ListBloc().dataProviderForTest = TestDataProviderError();

    await tester.pumpWidget(const ListPageWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final errorFinder = find.text('Error: $errorMessage');

    expect(errorFinder, findsOneWidget);
  });

  testWidgets('Widget is updated when stream is updated', (WidgetTester tester) async {
    // Inject error data provider
    ListBloc().dataProviderForTest = TestDataProviderError();

    await tester.pumpWidget(const ListPageWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final errorFinder = find.text('Error: $errorMessage');

    expect(errorFinder, findsOneWidget);

    // Inject no error data provider, trigger stream update
    ListBloc().dataProviderForTest = TestDataProvider();
    await ListBloc().loadItems();

    // Trigger widget to redraw its frames, this causes the stream builder to get the new data
    await tester.pump(Duration.zero);

    final item1Finder = find.text(itemTitleAlpha1);
    final item2Finder = find.text(itemTitleAlpha2);
    final item3Finder = find.text(itemTitleAlpha3);

    expect(item1Finder, findsOneWidget);
    expect(item2Finder, findsOneWidget);
    expect(item3Finder, findsOneWidget);

  });

}


class ListPageWrapper extends StatelessWidget {
  const ListPageWrapper({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ListPage(),
    );
  }
}