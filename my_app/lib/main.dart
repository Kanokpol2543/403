import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      title: 'Chilli Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  var image;
  String prediction = "";

  final String serverUrl = 'http://192.168.1.145:3000';

  Future<String> classifyImamge(File image) async {
    var stream = new http.ByteStream(image.openRead());
    var length = await image.length();
    var uri = Uri.parse('$serverUrl/detect');
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile =
        new http.MultipartFile('image', stream, length, filename: image.path);
    request.files.add(multipartFile);
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    String jsonString = responseString;
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    return jsonMap['prediction'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            height: size.height * 0.4,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: prediction == ""
                      ? AssetImage("assets/chilies.jpg")
                      : FileImage(File(image.path)) as ImageProvider<Object>,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.35,
            height: size.height * 0.65,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.0),
                  topRight: Radius.circular(36.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Prediction",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    prediction == "" ? "Select image" : "$prediction",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              image = await picker.getImage(
                                  source: ImageSource.camera,
                                  maxHeight: 300,
                                  maxWidth: 300,
                                  imageQuality: 100);
                              if (image != null) {
                                setState(() {
                                  prediction = 'Predicting...';
                                });
                                var predictedLabel =
                                    await classifyImamge(File(image.path));
                                if (predictedLabel == 'cannotdetect') {
                                  setState(() {
                                    prediction =
                                        'Can not detect chili in the picture.';
                                  });
                                } else {
                                  setState(() {
                                    prediction = predictedLabel;
                                  });
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(16),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.lightBlue,
                            ),
                          ),
                          Text(
                            "Take Photo",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              image = await picker.getImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 300,
                                  maxWidth: 300,
                                  imageQuality: 100);
                              if (image != null) {
                                setState(() {
                                  prediction = 'Predicting...';
                                });
                                var predictedLabel =
                                    await classifyImamge(File(image.path));
                                setState(() {
                                  prediction = predictedLabel;
                                });
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(16)),
                            child: Icon(
                              Icons.photo,
                              size: 35,
                              color: Colors.lightBlue,
                            ),
                          ),
                          Text(
                            "From Gallery",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
