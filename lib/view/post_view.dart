import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netgalpi/view/add_content_page.dart';
import 'package:netgalpi/view/components/photo_card.dart';
import 'package:image_picker/image_picker.dart';

class PostView extends StatefulWidget {
  const PostView({super.key, required this.url, required this.date, required this.title, required this.mention});
  final String url;
  final String date;
  final String title;
  final List<String> mention;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {

  XFile? _imageFile;

  Future _pickImageCamera() async {
    try {
      final XFile? cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() => _imageFile = cameraImage);
      return;
    } on Exception catch (e) {
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
      setState(() => _imageFile = pickedFileList);
    } on Exception catch (e) {
      print("wqwe");
      print(e);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AppBar(
              elevation: 0,
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close, size: 32, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                  splashColor: Colors.transparent,  
                  highlightColor: Colors.transparent,
                ),
                const SizedBox(width: 12,)
              ], 
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(28.0)
          ),
          boxShadow: [
            BoxShadow(blurRadius: 4.0, color: Colors.black26),
          ],
        ),
        width: 104,
        height: 56,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.pink,
            ),
            onPressed: () { 
              showDialog(
                context: context, 
                builder: (context) {
                return FractionallySizedBox(
                  widthFactor: 0.94,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 50,
                            width: 86,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: TextButton(
                              child: Text(
                                "업로드", 
                                style: TextStyle(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                                ),
                              onPressed: () {  }
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Dialog(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          insetPadding: EdgeInsets.all(0),
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: (_imageFile != null) ? Image.file(File(_imageFile!.path)) : Container(height: 10, width: 10, color: Colors.pink,),
                          )
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                _pickImageGallery();
                              },
                              child: Container(width: 100, height: 100, color: Colors.yellow,),
                            )
                          )
                        ],
                      ),
                      SizedBox(height: 36,)
                    ],
                  ),
                );
              });
            }, 
            icon: Icon(Icons.add, size: 20,), 
            label: Text("추가하기", 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 13),
            )
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                widget.date,
                style: const TextStyle(
                  color: Color.fromARGB(255, 90, 90, 90),
                  fontSize: 18,
                  letterSpacing: -0.4,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  height: 1.1,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 8,),
              RichText(
                text: TextSpan(
                style: const TextStyle(
                  color: Color.fromARGB(255, 138, 138, 138),
                  fontSize: 16,
                  height: 1,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
                children: [
                  ...widget.mention.map((e) => TextSpan(
                    children: [
                      const TextSpan(text: '@'),
                      TextSpan(text: e),
                      const TextSpan(text: ' '),
                    ]
                  ))
                ]
              )),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: PhotoCard(author: "author", imageUrl: "https://cdn.thescoop.co.kr/news/photo/202103/50023_70020_725.jpg",)
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: PhotoCard(author: "author", imageUrl: "https://blog.kakaocdn.net/dn/ofkSz/btrnDGj77N7/zKbTLYs1b4zUPq5jmpx8kk/img.jpg",)
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: PhotoCard(author: "author", imageUrl: "https://cdn.discordapp.com/attachments/797738827740479513/1068925429785825441/KakaoTalk_Photo_2023-01-27-23-50-35.jpeg",)
              )
            ],
          )
        ),
      ),
    );
    
  }
}