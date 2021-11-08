import 'package:ekuabo/controller/edit_profile_controller.dart';
import 'package:ekuabo/pages/edit_neighbourhood_details.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfile extends StatelessWidget {
  final _con = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    _con.fillvalues();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EkuaboString.edit_profile.text.medium.heightTight
                .size(18)
                .make()
                .pOnly(left: 10),
            UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
            VxCard(Column(
              children: [
                Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 10, maxHeight: 40),
                      child: TextFormField(
                        controller: _con.nameCtl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "username",
                            labelStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.secondColor),
                            hintText: "username",
                            hintStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.mainColor))),
                      ),
                    ),
                    16.heightBox,
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 10, maxHeight: 40),
                      child: TextFormField(
                        controller: _con.emailCtl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "email",
                            labelStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.secondColor),
                            hintText: "email",
                            hintStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.mainColor))),
                      ),
                    ),
                    16.heightBox,
                    Row(
                      children: [
                        _con.mediaFile == null
                            ? EkuaboString.uploadProfilePhoto.text.medium
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
                        16.widthBox,
                        Image.asset(
                          EkuaboAsset.ic_upload,
                          width: 16,
                          height: 16,
                        )
                      ],
                    ).onTap(() => _showPicker(context)),
                    16.heightBox,
                    EkuaboString.contact_information.text.medium.heightTight
                        .size(16)
                        .make(),
                    UnderlineWidget().getUnderlineWidget(),
                    16.heightBox,
                    // ConstrainedBox(
                    //   constraints:
                    //       const BoxConstraints(minHeight: 10, maxHeight: 40),
                    //   child: TextFormField(
                    //
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         labelText: "website",
                    //         labelStyle: const TextStyle(
                    //             fontFamily: EkuaboAsset.CERA_PRO_FONT,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w200,
                    //             color: MyColor.secondColor),
                    //         hintText: "website",
                    //         hintStyle: const TextStyle(
                    //             fontFamily: EkuaboAsset.CERA_PRO_FONT,
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.w200),
                    //         fillColor: Colors.white,
                    //         border: const OutlineInputBorder(
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(7)),
                    //             borderSide: BorderSide(
                    //                 width: 1, color: MyColor.mainColor))),
                    //   ),
                    // ),
                    16.heightBox,
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.contactNoCtl,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: EkuaboString.mobile,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: "1234567890",
                                  hintStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(
                                          width: 1, color: MyColor.mainColor))),
                            ),
                          ),
                        ),
                        16.widthBox,
                        Expanded(
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.homeContactCtl,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: EkuaboString.mobile,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: "1234567890",
                                  hintStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(
                                          width: 1, color: MyColor.mainColor))),
                            ),
                          ),
                        )
                      ],
                    ),
                    16.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EkuaboString.about.text.medium
                                .size(16)
                                .heightTight
                                .make(),
                            UnderlineWidget().getUnderlineWidget()
                          ],
                        ),
                        MaterialButton(
                          minWidth: 100,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditNeighbourhoodDetails()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: EkuaboString.editneighbourhood.text
                              .color(MyColor.lightestGrey)
                              .make(),
                          color: MyColor.mainColor,
                          height: 35,
                        )
                      ],
                    ),
                    // 16.heightBox,
                    // VxBox(
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton(
                    //       items: [],
                    //       hint: "Lorem ipsum"
                    //           .text
                    //           .size(14)
                    //           .color(Colors.grey.withOpacity(0.6))
                    //           .make(),
                    //       icon: Image.asset(
                    //         EkuaboAsset.ic_down_arrow,
                    //         width: 15,
                    //         height: 16,
                    //       ),
                    //       isExpanded: true,
                    //     ),
                    //   ).p(10),
                    // )
                    //     .withDecoration(BoxDecoration(
                    //         color: Colors.white,
                    //         border: Border.all(color: Colors.black, width: 1),
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(7))))
                    //     .height(40)
                    //     .make(),
                    16.heightBox,
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 10, maxHeight: 40),
                      child: TextFormField(
                        controller: _con.homeTownCtl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "Home Town",
                            labelStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.secondColor),
                            hintText: "Home Town",
                            hintStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.mainColor))),
                      ),
                    ),
                    16.heightBox,
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.occupationCtl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Occupation",
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: "Occupation",
                                  hintStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(
                                          width: 1, color: MyColor.mainColor))),
                            ),
                          ),
                        ),
                        16.widthBox,
                        Expanded(
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.interestCtl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: "interest",
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: "interest",
                                  hintStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(
                                          width: 1, color: MyColor.mainColor))),
                            ),
                          ),
                        )
                      ],
                    ),
                    16.heightBox,
                    TextFormField(
                      controller: _con.funFactCtl,
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 5,
                      decoration: InputDecoration(
                          filled: true,
                          alignLabelWithHint: true,
                          labelText: "fun_facts",
                          labelStyle: const TextStyle(
                              fontFamily: EkuaboAsset.CERA_PRO_FONT,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: MyColor.secondColor),
                          hintText: "fun_facts",
                          hintStyle: const TextStyle(
                              fontFamily: EkuaboAsset.CERA_PRO_FONT,
                              fontSize: 12,
                              fontWeight: FontWeight.w200),
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  width: 1, color: MyColor.mainColor))),
                    ),
                  ],
                )).p(15),
                MaterialButton(
                  minWidth: 170,
                  onPressed: () => _con.updateProfile(context),
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
                .elevation(7)
                .color(MyColor.lightGrey)
                .withRounded(value: 10)
                .make()
                .w(double.infinity)
                .pOnly(top: 16, left: 16, right: 16),
            Image.asset(
              EkuaboAsset.bottom_image,
              width: double.infinity,
            )
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
