import 'package:ekuabo/controller/add_banner_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';

import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateMyAd extends StatefulWidget {
  @override
  State<CreateMyAd> createState() => _CreateMyAdState();
}

class _CreateMyAdState extends State<CreateMyAd> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<AddBannerController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBannerController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(context),
        body: _con.bannerSlots.isNotEmpty
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
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
                            EkuaboString
                                .myPostedBannerAd.text.medium.heightTight
                                .size(18)
                                .make()
                                .pOnly(left: 10),
                            UnderlineWidget()
                                .getUnderlineWidget()
                                .pOnly(left: 10)
                          ],
                        )
                      ],
                    ),
                    16.heightBox,
                    VxCard(Column(
                      children: [
                        Form(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minHeight: 10, maxHeight: 40),
                              child: TextFormField(
                                controller: _con.bannerTitleCtl,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: EkuaboString.enterBannerTitle,
                                    labelStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: MyColor.secondColor),
                                    hintText: EkuaboString.enterBannerTitle,
                                    hintStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: MyColor.mainColor))),
                              ),
                            ),
                            16.heightBox,
                            VxBox(
                                    child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(flex: 1, child: VxBox().make()),
                                    Expanded(
                                      flex: 1,
                                      child: EkuaboString.page.text.medium
                                          .size(12)
                                          .make(),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: EkuaboString.slot.text.medium
                                          .size(12)
                                          .make(),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: EkuaboString.amount.text.medium
                                          .size(12)
                                          .make(),
                                    )
                                  ],
                                ),
                                ListView.builder(
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Checkbox(
                                              value: _con
                                                  .bannerSlots[index].isChecked,
                                              onChanged: (v) {
                                                _con.bannerSlots[index]
                                                        .isChecked =
                                                    !_con.bannerSlots[index]
                                                        .isChecked;
                                                _con.update();
                                              })),
                                      Expanded(
                                        flex: 2,
                                        child: _con.bannerSlots[index].pageName
                                            .text.medium
                                            .size(12)
                                            .color(MyColor.blackColor
                                                .withOpacity(0.6))
                                            .make(),
                                      ),
                                      10.widthBox,
                                      Expanded(
                                        flex: 2,
                                        child: _con.bannerSlots[index].slotName
                                            .text.medium
                                            .size(12)
                                            .color(MyColor.blackColor
                                                .withOpacity(0.6))
                                            .make(),
                                      ),
                                      10.widthBox,
                                      Expanded(
                                        flex: 2,
                                        child: _con.bannerSlots[index].price
                                            .text.medium
                                            .size(12)
                                            .color(MyColor.blackColor
                                                .withOpacity(0.6))
                                            .make(),
                                      ),
                                    ],
                                  ),
                                  shrinkWrap: true,
                                  itemCount: _con.bannerSlots.length,
                                )
                                /* Row(
                                  children: [
                                    Expanded(flex:2,child: Checkbox(value: true, onChanged:(v){})),
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.homePage
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.horizontal
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: "1"
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(flex:2,child: Checkbox(value: true, onChanged:(v){})),
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.searchPage
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.horizontal
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: "1"
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(flex:2,child: Checkbox(value: true, onChanged:(v){})),
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.searchPage
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.vertical
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: "1"
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(flex:2,child: Checkbox(value: true, onChanged:(v){})),
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.marketPlacePage
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.horizontal
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: "1"
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [

                                    Expanded(flex:2,child: Checkbox(value: true, onChanged:(v){})),

                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.marketPlacePage
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,

                                    Expanded(
                                      flex:2,
                                      child: EkuaboString.vertical
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                    10.widthBox,
                                    Expanded(
                                      flex:2,
                                      child: "1"
                                          .text
                                          .medium
                                          .size(12)
                                          .color(MyColor.blackColor.withOpacity(0.6))
                                          .make(),
                                    ),
                                  ],
                                ),*/
                              ],
                            ).pOnly(top: 10, bottom: 10))
                                .withRounded(value: 10)
                                .border(color: MyColor.lightGrey, width: 0.4)
                                .white
                                .width(double.infinity)
                                .make(),
                            16.heightBox,
                            Row(
                              children: [
                                _con.mediaFile == null
                                    ? EkuaboString.uploadBannerImage.text.medium
                                        .size(11)
                                        .make()
                                    : _con.mediaFile.path
                                        .substring(
                                            _con.mediaFile.path
                                                    .lastIndexOf('/') +
                                                1,
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
                            ).onTap(() => _showPicker(context)),
                            16.heightBox,
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minHeight: 10, maxHeight: 40),
                              child: TextFormField(
                                controller: _con.bannerUrlCtl,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: EkuaboString.enterRedirectionUrl,
                                    labelStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: MyColor.secondColor),
                                    hintText: EkuaboString.enterRedirectionUrl,
                                    hintStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: MyColor.mainColor))),
                              ),
                            ),
                            16.heightBox,
                            TextFormField(
                              controller: _con.bannerDescCtl,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 5,
                              decoration: InputDecoration(
                                  filled: true,
                                  alignLabelWithHint: true,
                                  labelText: EkuaboString.enterDesc,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: EkuaboString.enterDesc,
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
                            16.heightBox,
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minHeight: 10, maxHeight: 40),
                              child: TextFormField(
                                controller: _con.bannerDaysCtl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: EkuaboString.enterNoOfDays,
                                    labelStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: MyColor.secondColor),
                                    hintText: EkuaboString.enterNoOfDays,
                                    hintStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: MyColor.mainColor))),
                              ),
                            ),
                            16.heightBox,
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minHeight: 10, maxHeight: 40),
                              child: TextFormField(
                                controller: _con.bannerPriceCtl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: EkuaboString.enterProductPrice,
                                    labelStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: MyColor.secondColor),
                                    hintText: EkuaboString.enterProductPrice,
                                    hintStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: MyColor.mainColor))),
                              ),
                            ),
                          ],
                        )).p(15),
                        MaterialButton(
                          minWidth: 170,
                          onPressed: () {
                            _con.mediaFile == null
                                ? (_con.createMyAd(context, _homeController))
                                : (_con.createMyAdwithImage(
                                    context, _homeController, _con.mediaFile));
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
                        ).pOnly(bottom: 50),
                      ],
                    ))
                        .elevation(7)
                        .withRounded(value: 10)
                        .color(MyColor.lightGrey)
                        .make()
                        .pOnly(left: 16, right: 16),
                    Image.asset(
                      EkuaboAsset.bottom_image,
                      width: double.infinity,
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      initState: (_) {
        _con.getBannerSlot();
      },
    );
  }

  Future _showPicker(context) {
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
    _con.update();
  }
}
