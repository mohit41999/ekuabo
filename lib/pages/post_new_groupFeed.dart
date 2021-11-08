import 'package:ekuabo/controller/group_new_feed_controller.dart';
import 'package:ekuabo/controller/new_feed_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class PostNewGroupFeed extends StatefulWidget {
  final String group_id;

  const PostNewGroupFeed({Key key, @required this.group_id}) : super(key: key);
  @override
  _PostNewGroupFeedState createState() => _PostNewGroupFeedState();
}

class _PostNewGroupFeedState extends State<PostNewGroupFeed> {
  final _con = Get.find<GroupNewFeedController>();

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
            EkuaboString.postEvent.text.medium.size(18).make().pOnly(left: 10),
            UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
            20.heightBox,
            Obx(() => Row(
                  children: [
                    EkuaboString.typeOfPost.text.medium
                        .size(15)
                        .make()
                        .pOnly(left: 10),
                    Radio(
                      value: EkuaboString.message,
                      groupValue: _con.typeOfPost.value,
                      onChanged: (value) =>
                          _con.changeEventType(EkuaboString.message),
                    ).pOnly(left: 10),
                    EkuaboString.message.text.medium
                        .size(13)
                        .color(_con.typeOfPost.value == EkuaboString.message
                            ? MyColor.mainColor.withOpacity(0.8)
                            : Colors.grey)
                        .make(),
                    Radio(
                      value: EkuaboString.event,
                      groupValue: _con.typeOfPost.value,
                      onChanged: (value) =>
                          _con.changeEventType(EkuaboString.event),
                    ).pOnly(left: 10),
                    EkuaboString.event.text.medium
                        .size(13)
                        .color(_con.typeOfPost.value == EkuaboString.event
                            ? MyColor.mainColor.withOpacity(0.8)
                            : Colors.grey)
                        .make(),
                  ],
                )),
            10.heightBox,
            VxCard(Column(
              children: [
                Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _con.messageCtl,
                      keyboardType: TextInputType.multiline,
                      minLines: 10,
                      maxLines: 10,
                      decoration: const InputDecoration(
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
                            ? EkuaboString.uploadMedia.text.medium
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
                    ).onTap(() => _showPicker(context))
                  ],
                )).p(15),
                MaterialButton(
                  minWidth: 170,
                  onPressed: () {
                    setState(() {
                      _con.mediaFile == null
                          ? _con.addFeed(context, widget.group_id)
                          : _con.addFeedwithImage(
                              context, _con.mediaFile, widget.group_id);
                    });
                  },
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

  Future _imgFromCamera() async {
    var image = await _con.picker
        .getImage(source: ImageSource.camera, imageQuality: 50);
    _con.mediaFile = image;
    _con.update();
  }

  Future _imgFromGallery() async {
    var image = await _con.picker
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    _con.mediaFile = image;
  }
}
