import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_upload_foto/upload_service.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Camera"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.file_upload), onPressed: _onClickUpload)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tire uma foto',
              style: TextStyle(fontSize: 25),
            ),
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClickCamera,
        tooltip: 'Tirar foto',
        child: Icon(Icons.camera),
      ),
    );
  }

  void _onClickCamera() async {

    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }


  void _onClickUpload() async {

    if (_image != null) {
      String url = await UploadService.upload(_image);
      print("URL: $url");
    }
  }
}
