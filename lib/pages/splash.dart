import 'dart:async';

import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusManager.instance.primaryFocus.unfocus();
      _startTimer(context);
    });
    return Scaffold(
      body:Stack(
        fit: StackFit.expand,
        children:[
         const FlutterLogo(size: 70,).objectCenter(),
         const CircularProgressIndicator().objectBottomCenter().p(30)
        ],
      ),
    );
  }

  void _startTimer(BuildContext context) {
    Timer(const Duration(seconds: 3), ()async{
    if(await PrefManager.isSessionStart()==null)
      {
        Get.offNamed(EkuaboRoute.signInScreen);
      }
    else
      {
        Get.offNamed(EkuaboRoute.homeScreen);
      }
    });
  }
}
