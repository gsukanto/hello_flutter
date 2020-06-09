import 'package:flutter/material.dart';
import 'package:hello_flutter/details/details_bloc.dart';
import 'package:hello_flutter/list/list_bloc.dart';
import 'package:hello_flutter/list/model.dart';
import 'package:hello_flutter/constants.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    DetailsBloc().getItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<Item>(
            stream: DetailsBloc().outItem,
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Text(snapshot.data.title);
              }
            },
          ),
        ),

        body: StreamBuilder<Item>(
          stream: DetailsBloc().outItem,
          builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _buildDetailsView(snapshot.data);
            }
          },
        ),
    );
  }

  Widget _buildDetailsView(Item item) {
    final Widget button = item.selected? RaisedButton(
        onPressed: () => ListBloc().deSelectItem(widget.id),
        child: Text(removeButton)
    ):
    RaisedButton(
        onPressed: () => ListBloc().selectItem(widget.id),
        child: Text(selectButton)
    );
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(item.selected?getSelectedTitle(item.title):item.title, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(item.description),
          button
        ],
      ),
    );
  }
}