import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EcuaboAppBar
{
  Widget getAppBar()
  {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Image.asset(EkuaboAsset.ic_app_logo,width: 118,
        height: 49,),
      centerTitle: true,
    );
  }
}