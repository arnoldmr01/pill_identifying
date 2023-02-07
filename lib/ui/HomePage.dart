import 'package:flutter/material.dart';
import '../helpers.dart';
import 'models/Record.dart';
import 'models/RecordList.dart';
import 'models/RecordService.dart';
import 'DetailsPage.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage2> {
  final TextEditingController _filter = new TextEditingController();

  RecordList _records = new RecordList(records: []);
  RecordList _filteredRecords = new RecordList(records: []);

  String _searchText = "";

  Icon _searchIcon = new Icon(
    Icons.search,
    color: appDarkGreyColor,
  );

  Widget _appBarTitle = new Text(
    appTitle,
    style: TextStyle(color: appDarkGreyColor),
  );

  @override
  void initState() {
    super.initState();

    _records.records = [];
    _filteredRecords.records = [];

    _getRecords();
  }

  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    setState(() {
      for (Record record in records.records) {
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: RiceWhite,
      body: _buildList(context),
      resizeToAvoidBottomInset: false,
    );
  }

  AppBar _buildBar(BuildContext context) {
    return new AppBar(
        elevation: 0.1,
        backgroundColor: RiceWhite,
        centerTitle: true,
        title: _appBarTitle,
        leading: new IconButton(icon: _searchIcon, onPressed: _searchPressed));
  }

  Widget _buildList(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      _filteredRecords.records = [];
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this
          ._filteredRecords
          .records
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Record record) {
    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: Hero(
                  tag: "avatar_" + record.name,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(record.photo),
                  ))),
          title: Text(
            record.name,
            style: TextStyle(
                color: appDarkGreyColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          // subtitle: Row(
          //   children: <Widget>[
          //     new Flexible(
          //         child: new Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //           RichText(
          //             text: TextSpan(
          //               text: record.address,
          //               style: TextStyle(color: Colors.white),
          //             ),
          //             maxLines: 3,
          //             softWrap: true,
          //           )
          //         ]))
          //   ],
          // ),
          trailing: Icon(Icons.keyboard_arrow_right, color: Orange, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new DetailPage(record: record)));
          },
        ),
      ),
    );
  }

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _resetRecords() {
    this._filteredRecords.records = [];
    for (Record record in _records.records) {
      this._filteredRecords.records.add(record);
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(
          Icons.close,
          color: appDarkGreyColor,
        );
        this._appBarTitle = new TextField(
          controller: _filter,
          style: new TextStyle(color: appDarkGreyColor),
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: appDarkGreyColor),
            fillColor: appDarkGreyColor,
            hintText: '藥品名稱',
            hintStyle: TextStyle(color: appDarkGreyColor),
          ),
        );
      } else {
        this._searchIcon = new Icon(
          Icons.search,
          color: appDarkGreyColor,
        );
        this._appBarTitle = new Text(
          appTitle,
          style: TextStyle(color: appDarkGreyColor),
        );
        _filter.clear();
      }
    });
  }
}
