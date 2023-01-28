import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';
import 'package:netgalpi/view/tag_view.dart';
import '../core/service/firestorage_apis.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

class UploadView extends StatefulWidget {
  const UploadView({Key? key}) : super(key: key);

  @override
  _UploadViewState createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  File? _image = null;
  Color btnColor = gray50;
  final picker = ImagePicker();
  var fs = const LocalFileSystem();
  var image;
  var mp4;

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    image = await picker.pickImage(source: imageSource);
    _image = fs.file(image!.path); // 가져온 이미지를 _image에 저장
    if (image != null)
      setState(() {
        btnColor = salmon500;
      });
  }

  Future getMp4(ImageSource imageSource) async {
    mp4 = await picker.pickImage(source: imageSource);
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return InkWell(
        onTap: () {
          getImage(ImageSource.gallery);
        },
        child: Container(
            color: const Color(0x50c9c9c9),
            width: MediaQuery.of(context).size.width / 10 * 9.5,
            height: MediaQuery.of(context).size.width,
            child: Center(
                child: _image == null
                    ? Container(
                        child: Column(children: [
                          SizedBox(height: 140),
                          Icon(EvaIcons.imageOutline),
                          Text('추억의 네컷을 올려주세요',
                              style: TextStyle(
                                  fontSize: 24, height: 3, color: gray300))
                        ]),
                      )
                    : Stack(children: [
                        Image.file(_image!),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                  btnColor = gray50;
                                });
                              },
                              icon: Icon(EvaIcons.close)),
                        )
                      ]))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final pad = MediaQuery.of(context).size.width / 10 * 0.5;
    return GetBuilder<PostListViewModel>(
        init: PostListViewModel(),
        builder: ((controller) => Scaffold(
            backgroundColor: const Color(0xfff4f3f9),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(EvaIcons.close)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(pad, 0, 0, 0),
                        child: const Text(
                          '사진 올리기',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              height: 1),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(pad, 0, 0, 0),
                        child: const Text(
                          '네컷 사진',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  showImage(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: const Text(
                          'mp4가 있나요?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            if (mp4 != null) {
                              FireStorage().uploadPostImg(mp4!);
                            }
                          },
                          child: const Text(
                            '업로드하기',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1,
                                color: salmon500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 30, 50, 20),
                        child: TextButton(
                          onPressed: () async {
                            if (_image != null) {
                              var url =
                                  await FireStorage().uploadPostImg(_image!);
                              controller.imageUrl = url;
                              controller.mp4Url = mp4;

                              Get.to(TagView());
                            }
                          },
                          child: Text(
                            '다음',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1,
                                color: btnColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))));
  }
}
