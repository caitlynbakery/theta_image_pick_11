import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panorama/panorama.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Image Files')), body: IOSPicker()),
    );
  }
}

class IOSPicker extends StatefulWidget {
  const IOSPicker({Key? key}) : super(key: key);

  @override
  State<IOSPicker> createState() => _IOSPickerState();
}

class _IOSPickerState extends State<IOSPicker> {
  File? image;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status;
    if (Platform.isIOS) {
      status = await Permission.photos.status;
    } else if (Platform.isAndroid) {
      status = await Permission.storage.status;
    } else {
      status = "error";
    }

    print(status);
    setState(() => _permissionStatus = status);
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final imageTemporary = File(image.path);
    print(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionStatus == PermissionStatus.granted) {
      return Scaffold(
          body: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: () {
              pickImage();
            },
            child: Text("PICK FROM GALLERY"),
          ),
          image != null ? Image.file(image!) : Container()
        ],
      )));
    } else {
      return Container(
        child: TextButton(
          child: Text("Grant Permission"),
          onPressed: () => requestPermission(
              Platform.isIOS ? Permission.photos : Permission.storage),
        ),
      );
    }
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

class FullScreenView extends StatelessWidget {
  const FullScreenView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Panorama()),
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
    final status = await Permission.photos.status;
    print(status);
    setState(() => _permissionStatus = status);
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionStatus == PermissionStatus.granted) {
      return SingleChildScrollView(
          child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child:
          //       Image.file(File('/storage/emulated/0/Pictures/R0010948.JPG')),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child:
          //       Image.file(File('/storage/emulated/0/Pictures/R0010973.JPG')),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Image.file(
          //       File('/storage/emulated/0/Pictures/myfile\ (2).jpg')),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(
                '/var/mobile/Containers/Data/Application/A0CD679E-4BDB-4CE9-A780-72999EFC117C/Library/Caches/myfile.jpg')),
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

// '/var/mobile/Containers/Data/Application/A0CD679E-4BDB-4CE9-A780-72999EFC117C/Library/Caches/myfile.jpg'

// /private/var/mobile/Containers/Data/Application/D7879CFC-AF96-45D2-B1CC-3218B9F99A63/tmp/image_picker_586F1084-577E-48C8-868E-FBC61A838FB7-655-0000003817B21D04.jpg