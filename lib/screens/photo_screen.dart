import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'list_screen.dart';

class Photo extends StatefulWidget {
  PhotoState createState() => PhotoState();
}

class PhotoState extends State<Photo> {

  static const routeName = 'photo';


  LocationData locationData;

  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});

  }

  File image;
  final picker = ImagePicker();
  int numWasted;

  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();

  void dispose() {
    myController.dispose();
    super.dispose();
  }

  int stringToInt(String input) {
    int output = int.parse(input);
    return output;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
    } );
  }

  void postImage(int items, double latitude, double longitude) async {
    var t = DateTime.now();
    final stringDate = t.toString();
    final String picName = 'photo';
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(picName + stringDate);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    print(url);
    //return url;
    await Firestore.instance
        .collection('photos')
        .add({
      "items": items,
      "date": DateTime.now(),
      "url": url,
      "latitude": latitude,
      "longitude": longitude
    });
  }

  Widget build(BuildContext context) {
    if (image == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
        ),
          body: Center(
            child: Semantics(
              button: true,
            enabled: true,
            onTapHint: 'Select a photo',
            child: RaisedButton(
              child: Text('Select photo'),
              onPressed:() {
                getImage();
              }
            )
            )
        )
      );
    }else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
        ),
        body: Center(
        child: Column(
          children: [
            Padding(
              padding: new EdgeInsets.all(25.0),
            child: Image.file(image, height: 150),
            ),
            //photo
            //number of items
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Semantics(
                    textField: true,
                    hint: 'enter the number of items wasted',
                    child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter the number of wasted items',
                    ),
                    controller: myController,
                    validator: (value){
                      if (value.isEmpty) {
                        return 'PLease enter a number';
                      }
                      return null;
                    },
                  ),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Semantics(
                      button: true,
                      enabled: true,
                      onTapHint: 'Submit new post',
                      child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          String currentInput = myController.text;
                          int numWasted = stringToInt(currentInput);
                          print('latitude: ${locationData.latitude}');
                          postImage(numWasted, locationData.latitude, locationData.longitude);
                          Navigator.of(context).pushNamed(ListScreenState.routeName);
                        }
                      },
                      child: Text('UPLOAD'),
                      )
                    ),
                  ),
                ],
              ),

            ),
    ]
    )
        ),
      );
    }
  }
}
