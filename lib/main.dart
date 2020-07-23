import 'dart:io';
import 'package:elearning/Encryption.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    request();
    encryptfile();
  }

  void request() async {
    await Permission.storage.request();
    if (Permission.storage.isDenied != null) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  void encryptfile() async {
    print(1);
    File file = await FilePicker.getFile();
    String filepath = file.path;
    print('File path recieved $filepath');
    String spath = filepath.substring(1, filepath.length);
    print('File slashed path is $spath');
    String encryptedFilePath = EncryptData.encrypt_file(spath);
    print(encryptedFilePath);
    Fluttertoast.showToast(
        msg:
            'Encryption successful.\nEncrypted file path : $encryptedFilePath');
  }

  void decryptfile() async {
    File file = await FilePicker.getFile();
    String filepath = file.path;
    print('File path recieved $filepath');
    String spath = filepath.substring(1, filepath.length);
    print('File slashed path is $spath');
    String decryptedFilePath = EncryptData.decrypt_file(spath);
    print(decryptedFilePath);
    Fluttertoast.showToast(
        msg:
            'Encryption successful.\nEncrypted file path : $decryptedFilePath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                encryptfile();
              },
              child: Text('Encrypt file'),
            ),
            FlatButton(
              onPressed: () {
                decryptfile();
              },
              child: Text('Decrypt file'),
            ),
          ],
        ),
      ),
    );
  }
}
