import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/view/detailed_view.dart';
import '../core/service/firestorage_apis.dart';
import '../core/viewmodel/post_viewmodel.dart';
import 'components/custom_textformfield.dart';
import '../core/service/firestore_apis.dart';

class TagView extends StatefulWidget {
  const TagView({Key? key}) : super(key: key);

  @override
  _TagViewState createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  File? _image;
  Color btnColor = gray50;
  final picker = ImagePicker();
  var _checkBoxValue1 = false;
  var title;
  List<String> mentionList = [];

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    if (image != null)
      setState(() {
        btnColor = salmon500;
        _image = File(image!.path); // 가져온 이미지를 _image에 저장
      });
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
                          Image.asset('assets/img.png',
                              width: 200, height: 100),
                          Text('추억의 네컷을 올려주세요',
                              style: TextStyle(
                                  fontSize: 28, height: 3, color: gray300))
                        ]),
                      )
                    : Stack(children: [
                        Image.file(File(_image!.path)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _image = null;
                                btnColor = gray50;
                              });
                            },
                            icon: Icon(EvaIcons.close)),
                      ]))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final pad = MediaQuery.of(context).size.width / 10 * 0.5;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.498),
          elevation: 0.0,
          iconTheme: const IconThemeData(color: gray600),
          leadingWidth: 200,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(pad, 10, 0, 0),
            child: Text(
              '태그하기',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 0.1,
                  color: gray700,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 50, 20),
                  child: Icon(
                    EvaIcons.close,
                    size: 36.0,
                  )),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        ),
        body: GetBuilder<PostListViewModel>(
            builder: ((controller) => Scaffold(
                backgroundColor: const Color(0xfff4f3f9),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          '제목',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              height: 1),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            width: pad * 17,
                            child: CustomTextFormField(
                              title: '',
                              hintText: '추억의 제목을 지어주세요!',
                              validatorFn: (value) {
                                if (value!.isEmpty) return '제목은 필수 항목입니다.';
                              },
                              onChangedFn: (value) {
                                title = value;
                                if (title != null)
                                  setState(() {
                                    btnColor = salmon500;
                                  });
                                else {
                                  setState(() {
                                    btnColor = gray50;
                                  });
                                }
                              },
                              onSavedFn: (value) {
                                controller.title = value;
                              },
                            ),
                          )),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          '함께 찍은 사진',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              height: 1),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            width: pad * 17,
                            child: CustomTextFormField(
                                title: '',
                                hintText: 'ex.홍길동 고길동...',
                                validatorFn: (value) {
                                  //if (value!.isEmpty) return '';
                                },
                                onSavedFn: (value) {},
                                onChangedFn: (value) {
                                  mentionList = value.toString().split(',');

                                  // if(value.toString()[-1]==''){
                                  //   value.toString() split(' ');
                                  // }
                                  // print(if(value.contains('')));
                                }),
                          )),
                      SizedBox(
                        height: 60.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: const Text(
                              '공개 범위',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                '피드에 이 네컷을 공유하고 싶나요?',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    height: 1,
                                    color: salmon500),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Transform.scale(
                                      scale: 1.2,
                                      child: Checkbox(
                                        activeColor: Colors.white,
                                        checkColor: Colors.red,
                                        value: _checkBoxValue1,
                                        onChanged: (value) {
                                          setState(() {
                                            _checkBoxValue1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Text(
                                      '네, 공유하고 싶습니다!',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          height: 1,
                                          color: gray600),
                                    )
                                  ]))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 30, 50, 20),
                            child: TextButton(
                              onPressed: () {
                                if (title == null) return;
                                if (mentionList != []) {
                                  mentionList.forEach(
                                    (element) async {
                                      if (await FirestoreApis()
                                              .mentionValidator(element) ==
                                          false) {
                                        Get.snackbar('Failed to register...',
                                            "멘션이 잘못되었습니다.");
                                      }
                                    },
                                  );
                                }

                                controller.check = _checkBoxValue1;
                                controller.mentionList = mentionList;
                                var pid = controller.finalPost(
                                    controller.imageUrl!,
                                    controller.mp4Url!,
                                    title,
                                    _checkBoxValue1,
                                    mentionList);
                                controller.getPost();
                                Get.to(
                                    () => DetailedView(index: 0, close: true));
                              },
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '올리기',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        height: 1,
                                        color: btnColor),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )))));
  }
}
