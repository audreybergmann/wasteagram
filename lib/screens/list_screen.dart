import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'detail_screen.dart';
import 'photo_screen.dart';

class ListScreen extends StatefulWidget {
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {

  static const routeName = '/';

  int itemCount = 0;



  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    Timestamp t = document['date'];
    DateTime d = t.toDate();
    final f = new DateFormat('EEEE, MMM d' );

    itemCount = itemCount + document['items'];
    return ListTile(
      title: Column(
        children:[
          Semantics(
            button: true,
          enabled: true,
          onTapHint: 'See details',
          child: Row(
          children: [
          Expanded(
            child: Text(
             f.format(d),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              document['items'].toString(),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5,
            ),
          ),
        ],
      ),
        ),
         Expanded(
        child: SizedBox(
           height: 20
         ),
         ),
         Expanded(
        child: const Divider(
            color: Colors.black,
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 0,
          ),
          )
      ]

      ),
      onTap: () {
        Navigator.pushNamed(context, DetailState.routeName, arguments: ScreenArguments(document['items'], document['date'], document['url'], document['latitude'], document['longitude']));
        print('should go to detail screen');
      },
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Wasteagram - $itemCount'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('photos').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data.documents.length == 0) return Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          }
      ),

      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Create a new food waste post',
        child:FloatingActionButton(
          onPressed: () => addNewEntry(context),
          child: const Icon(Icons.add)
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  void addNewEntry (BuildContext context) {
    Navigator.of(context).pushNamed(PhotoState.routeName);
  }
}
class ScreenArguments {
  final int items;
  final Timestamp date;
  final String url;
  final double latitude;
  final double longitude;

  ScreenArguments(this.items, this.date, this.url, this.latitude, this.longitude);
}
