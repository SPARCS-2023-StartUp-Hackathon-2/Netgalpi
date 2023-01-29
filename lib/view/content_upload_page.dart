import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netgalpi/core/viewmodel/content_viewmodel.dart';
import 'package:netgalpi/view/components/custom_textformfield.dart';

import '../constants.dart';

class ContentUploadPage extends StatelessWidget {
  File? _imageFile;
  String pId;
  ContentUploadPage(this._imageFile, this.pId, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentViewModel>(builder: (controller) {
      controller.contentImgUrl = _imageFile!.path;
      controller.contentPostId = pId;
      return Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Image.file(_imageFile!),
                  Form(
                    child: Column(
                      children: [
                        CustomTextFormField(
                            title: '공유글',
                            hintText: '공유하고 싶은 글을 적어보세요',
                            validatorFn: (value) {
                              return null;
                            },
                            onSavedFn: (value) {
                              controller.contentText = value;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          child: Text(
                            '추억 등록하기',
                            style: TextStyle(
                                color: salmon500,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            controller.addContent();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )));
    });
  }
}
