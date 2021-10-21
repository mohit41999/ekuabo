import 'package:ekuabo/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UnderlineWidget{
   Widget getUnderlineWidget()
  {
   return VxBox().width(50).height(3).color(MyColor.mainColor).withRounded(value: 5).make();
  }
}