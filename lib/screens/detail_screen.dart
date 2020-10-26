import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'list_screen.dart';

class Detail extends StatefulWidget {
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {

  static const routeName = 'detail';


  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    Timestamp t = args.date;
    DateTime d = t.toDate();
    String items = args.items.toString();
    print(args.latitude);
    String lat = args.latitude.toString();
    String long = args.longitude.toString();

    final f = new DateFormat('EEE, MMM d, yyyy' );

    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(height: 20),
               Expanded(
                 child: Text(f.format(d), style: TextStyle(fontSize: 30)),
               ),
               Expanded(
                child: Image.network(args.url),
               ),
               SizedBox(
                 height: 50,
               ),
               Expanded(
                 child: Text('Items Wasted: $items', style: TextStyle(fontSize: 25)),
               ),
               Expanded(
                 child: Text('($lat, $long)', style: TextStyle(fontSize: 20)),
               ),
             ]
            ),
      ),
      );
  }
}
