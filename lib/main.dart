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
  // PermissionStatus _permissionStatus = PermissionStatus.denied;

  // @override
  // void initState() {
  //   super.initState();

  //   () async {
  //     _permissionStatus = await Permission.storage.status;

  //     if (_permissionStatus != PermissionStatus.granted) {
  //       PermissionStatus permissionStatus = await Permission.storage.request();
  //       setState(() {
  //         _permissionStatus = permissionStatus;
  //       });
  //     }
  //   }();
  // }

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
            child:
                Image.file(File('/storage/emulated/0/Pictures/R0010973.JPG')),
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
    return Container(
      child: TextButton(
          child: Text('Grant Permission'),
          onPressed: () {
            requestPermission(Permission.photos);
          }),
    );
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
