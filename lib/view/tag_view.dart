import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netgalpi/constants.dart';
import '../core/service/firestorage_apis.dart';
import '../core/viewmodel/post_viewmodel.dart';
import 'components/custom_textformfield.dart';

class TagView extends StatefulWidget {
  const TagView({Key? key}) : super(key: key);

  @override
  _TagViewState createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  File? _image;
  Color btnColor = gray50;
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    if(image!=null)
      setState(() {
        btnColor = salmon500;
        _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {

    return 
        InkWell(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
               child: Container(
                color: const Color(0x50c9c9c9),
                width: MediaQuery.of(context).size.width/10*9.5,
                height: MediaQuery.of(context).size.width,
            
                child: Center(
                  
                    child: _image == null
                        ?
                        Container(
                          child: Column(
                          children: [

                          SizedBox(height: 140),
                          Image.asset('assets/img.png', width: 200, height: 100),
                          
                          Text('추억의 네컷을 올려주세요',
                          style: TextStyle(fontSize: 24, height: 3, color: gray300))
                          ]),
                        )
                        : 
                        Stack(
                  
                          children: [
                          
                        Image.file(File(_image!.path)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _image = null;
                                btnColor = gray50;
                              });
                              
                            },

                          icon: Icon(EvaIcons.close)),]))
              )
              );
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final pad = MediaQuery.of(context).size.width/10*0.5;

    return GetBuilder<PostListViewModel>(
        init: PostListViewModel(),
        builder: ((controller) => Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 30, 0),
                      child:     
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context); //뒤로가기
                          },
                          icon: Icon(EvaIcons.close))
                        //Image.asset('assets/x.png', width: 200, height: 100),
                      ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(pad, 0, 0, 0),
                      child: const Text(
                        '태그하기',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, height: 1),
                      ),
                    )
                  ],
                ),
             
              SizedBox(height: 30.0),
                
                Container(
                  width: pad*19,
                  child: CustomTextFormField(
                    title: '제목',
                    hintText: '추억의 제목을 지어주세요!',
                    validatorFn: (value) {
                      if (value!.isEmpty) return '제목은 필수 항목입니다.';
                    },
                    onSavedFn: (value) {
                    },
                  ),
                ),
                
                Container(
                  width: pad*19,
                  
                  child: CustomTextFormField(
                    title: '함께 찍은 사람',
                    hintText: 'ex.홍길동 고길동...',
                    
                    validatorFn: (value) {
                      //if (value!.isEmpty) return '';
                    },
                    onSavedFn: (value) {
                    },
                    onChangedFn: (value) {
                      print(value);  
                    }
                  ),
                ),
              SizedBox(
                height: 20.0,
              ),
                Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: const Text(
                      '공개 범위',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1),
                    ),
                  ),
                  Padding(
                             
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {  },
                              child: const Text(
                                '피드에 이 네컷을 공유하고 싶나요?',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1, color: salmon500),
                                
                              ),
                            ),
                          ),
                ],
              ),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
<<<<<<< Updated upstream
                              padding: EdgeInsets.fromLTRB(10, 30, 50, 20),
                            child: TextButton(
                              onPressed: () { _image!=null? _image=null: _image=null;},
                              child: Text(
                                '다음',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1, color: btnColor),
                              ),
                            ),
=======
                        padding: EdgeInsets.fromLTRB(10, 30, 50, 20),
                        child: TextButton(
                          onPressed: () {
                            controller.check = _checkBoxValue1;
                            controller.mentionList = mentionList;
                            controller.finalPost(controller.imageUrl!, "mp4",
                                title, _checkBoxValue1, mentionList);
                            //GetX.to()
                          },
                          child: Text(
                            '다음',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1,
                                color: btnColor),
>>>>>>> Stashed changes
                          ),
                    ],
                  ),
                ],
          ),
        ))
        )
    );
  }
}