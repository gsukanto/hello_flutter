import 'package:flutter/material.dart';
import 'package:hello_flutter/details/details_page.dart';
import 'package:hello_flutter/list/model.dart';
import 'package:hello_flutter/list/list_bloc.dart';
import 'package:hello_flutter/constants.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    ListBloc().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listPageTitle),
      ),
      body: StreamBuilder<ListOfItems>(
        stream: ListBloc().outItems,
        builder: (BuildContext context, AsyncSnapshot<ListOfItems> snapshot) {
          if (snapshot.hasError) {
            return _displayErrorMessage(snapshot.error.toString());
          } else if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data.errorMessage != null){
            return _displayErrorMessage(snapshot.data.errorMessage);
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data.items.map((Item value) {
                return _buildListRow(value);
              }).toList(),
            );
          }
        },
      )
    );
  }

  Widget _displayErrorMessage(String errorMessage) {
    return Container(padding: const EdgeInsets.all(16.0),child: Center(child: Text('Error: $errorMessage')));
  }

  Widget _buildListRow(Item item) {
    return Container(
        color: item.selected? Colors.green.shade200 : Colors.white,
        child: ListTile(
          title: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold),),
          onTap: () {
            _displayDetails(item);
          },
        )
    );
  }

  Future<void> _displayDetails(Item item) async {
    await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return DetailsPage(id: item.id);
          },
        )
    );
  }
}