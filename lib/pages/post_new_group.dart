import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/post_new_group_controller.dart';

import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class PostNewGroup extends StatefulWidget {
  @override
  State<PostNewGroup> createState() => _PostNewGroupState();
}

class _PostNewGroupState extends State<PostNewGroup> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<PostNewGroupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => _homeController.bottomNavPop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyColor.mainColor,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EkuaboString.post_a_new_group.text.medium
                        .size(18)
                        .make()
                        .pOnly(left: 10),
                    UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
                  ],
                )
              ],
            ),
            20.heightBox,
            VxCard(Column(
              children: [
                Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.heightBox,
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 40),
                      child: TextFormField(
                        controller: _con.groupNameCtl,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: EkuaboString.enterGroupName,
                            hintText: EkuaboString.enterGroupName,
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.blackColor),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.blackColor),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.mainColor))),
                      ),
                    ),
                    16.heightBox,
                    TextFormField(
                      controller: _con.groupDescCtl,
                      keyboardType: TextInputType.multiline,
                      minLines: 7,
                      maxLines: 7,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: EkuaboString.enterGroupDesc,
                          hintText: EkuaboString.enterGroupDesc,
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: MyColor.blackColor),
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: MyColor.blackColor),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  width: 1, color: MyColor.mainColor))),
                    ),
                    16.heightBox,
                    Row(
                      children: [
                        _con.mediaFile == null
                            ? EkuaboString.uploadImage.text.medium
                                .size(11)
                                .make()
                            : _con.mediaFile.path
                                .substring(
                                    _con.mediaFile.path.lastIndexOf('/') + 1,
                                    _con.mediaFile.path.length)
                                .text
                                .medium
                                .size(11)
                                .make(),
                        10.widthBox,
                        Image.asset(
                          EkuaboAsset.ic_upload,
                          width: 21,
                          height: 14,
                        )
                      ],
                    ).onTap(() {
                      setState(() {
                        _showPicker(context);
                      });
                    }),
                  ],
                )).p(15),
                MaterialButton(
                  minWidth: 170,
                  onPressed: () => _con.addNewGroup(context),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: EkuaboString.submit
                      .toUpperCase()
                      .text
                      .color(MyColor.lightestGrey)
                      .make(),
                  color: MyColor.mainColor,
                  height: 45,
                ).pOnly(bottom: 50)
              ],
            ))
                .elevation(5)
                .color(const Color(0xffF5F5F5))
                .makeCentered()
                .cornerRadius(12)
                .p(10),
            Image.asset(
              EkuaboAsset.bottom_image,
              width: double.infinity,
            ).objectBottomLeft()
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    var image = await _con.picker
        .getImage(source: ImageSource.camera, imageQuality: 50);
    _con.mediaFile = image;
    _con.update();
  }

  _imgFromGallery() async {
    var image = await _con.picker
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    _con.mediaFile = image;
  }
}
