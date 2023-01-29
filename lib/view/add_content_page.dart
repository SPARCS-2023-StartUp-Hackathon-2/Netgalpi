import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddContentPage extends StatefulWidget {
  const AddContentPage({super.key});

  @override
  State<AddContentPage> createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {

  XFile? _imageFile;
  void _addImageFile(XFile? value) {
    if(value != null) {
      _imageFile = value;
    }
  }

  Future _pickImageCamera() async {
    try {
      final XFile? cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        _addImageFile(cameraImage);
      });
      return;
    } on Exception catch (e) {
      print("poipoi "); 
      print(e);
      return;
    }
  }

  Future _pickImageGallery() async {
    try {
      final XFile? pickedFileList = await ImagePicker().pickImage(
        maxWidth: 4096,
        maxHeight: 4096,
        source: ImageSource.gallery
      );
      setState(() {
        _addImageFile(pickedFileList);
      });
    } on Exception catch (e) {
      print("wqwe");
      print(e);
    }
    return;
  }

  Widget photobottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "프로젝트 홍보용 사진을 선택하세요",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.black54,
                ),
                icon: Icon(Icons.camera),
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  _pickImageCamera();
                },
                label: Text("카메라"),
              ),
              SizedBox(width: 16,),
              TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.black54,
                ),
                icon: Icon(Icons.image),
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  _pickImageGallery();
                },
                label: Text("갤러리"),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          _pickImageGallery();
        },
        child: Container(width: 100, height: 100, color: Colors.yellow,),
      )
    );
  }
}