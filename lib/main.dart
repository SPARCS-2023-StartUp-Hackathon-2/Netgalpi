import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:netgalpi/firebase_options.dart';
import 'package:netgalpi/view/auth/login_view.dart';

import 'helper/binding.dart';
import 'view/control_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      //home: const ControlView(),
      home: ControlView(),
      debugShowCheckedModeBanner: false,
      title: '넷갈피',
    );
  }
}
