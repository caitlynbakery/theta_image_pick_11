import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Image Files')), body: FileImage()),
    );
  }
}

class FileImage extends StatefulWidget {
  const FileImage({Key? key}) : super(key: key);

  @override
  State<FileImage> createState() => _FileImageState();
}

class _FileImageState extends State<FileImage> {
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await Permission.storage.status;
    print(status);
    setState(() => _permissionStatus = status);
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionStatus == PermissionStatus.granted) {
      return SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Image.file(File('/storage/emulated/0/Pictures/R0010948.JPG')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
                File('/storage/emulated/0/Pictures/myfile\ (4).jpg')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
                File('/storage/emulated/0/Pictures/myfile\ (2).jpg')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
                File('/storage/emulated/0/Pictures/myfile\ (5).jpg')),
          ),
        ],
      ));
    }
    return Container();
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }
}
