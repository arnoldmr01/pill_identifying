import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/helpers.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'HomePage.dart';

class DetectMain extends StatefulWidget {
  @override
  _DetectMainState createState() => new _DetectMainState();
}

class _DetectMainState extends State<DetectMain> {
  File _image;
  double _imageWidth;
  double _imageHeight;
  var _recognitions;

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = (await Tflite.loadModel(
        model: "assets/mobilenet.tflite",
        labels: "assets/labels.txt",
      ));
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  // run prediction using TFLite on given image
  Future predict(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    print(recognitions);

    setState(() {
      _recognitions = recognitions;
    });
  }

  // send image to predict method selected from gallery or camera
  sendImage(File image) async {
    if (image == null) return;
    await predict(image);

    // get the width and height of selected image
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _image = image;
          });
        })));
  }

  // select image from gallery
  final ImagePicker _picker = ImagePicker();
  selectFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
    File file = File(image.path);
    sendImage(file);
  }

  // select image from camera
  selectFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {});
    File file = File(image.path);
    sendImage(file);
  }

  @override
  void initState() {
    super.initState();

    loadModel().then((val) {
      setState(() {});
    });
  }

  Widget printValue(rcg) {
    if (rcg == null) {
      return Text('',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    } else if (rcg.isEmpty) {
      return Center(
        child: Text("無法辨識",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Center(
        child: Text(
          "預測 : " + _recognitions[0]['label'].toString().toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // gets called every time the widget need to re-render or build
  @override
  Widget build(BuildContext context) {
    // get the width and height of current screen the app is running on
    Size size = MediaQuery.of(context).size;

    // initialize two variables that will represent final width and height of the segmentation
    // and image preview on screen
    double finalW;
    double finalH;

    // when the app is first launch usually image width and height will be null
    // therefore for default value screen width and height is given
    if (_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    } else {
      // ratio width and ratio height will given ratio to
//      // scale up or down the preview image
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      finalW = _imageWidth * ratioW * .85;
      finalH = _imageHeight * ratioH * .35;
    }

    //button to data

    //List<Widget> stackChildren = [];
    return Scaffold(
      backgroundColor: RiceWhite,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Colors.white, //change your color here
      //   ),
      //   title: Text(
      //     "藥物辨識系統",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: DarkGreen,
      //   centerTitle: true,
      // ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: printValue(_recognitions),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: _image == null
                ? Center(
                    child: Text("選擇相機或是相簿",
                        style: TextStyle(fontSize: 20, color: DarkGreen)),
                  )
                : Center(
                    child: Image.file(_image,
                        fit: BoxFit.fill, width: finalW, height: finalH)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  height: 70,
                  width: 150,
                  color: Orange,
                  child: TextButton.icon(
                    onPressed: selectFromCamera,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: Text(
                      "相機",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                ),
              ),
              Container(
                height: 70,
                width: 150,
                color: Orange,
                child: TextButton.icon(
                  onPressed: selectFromGallery,
                  icon: Icon(
                    Icons.file_upload,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: Text(
                    "相簿",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
