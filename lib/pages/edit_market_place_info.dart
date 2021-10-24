import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class EditMarketPlaceInfo extends StatefulWidget {
  final String market_id;
  const EditMarketPlaceInfo({Key key, this.market_id}) : super(key: key);

  @override
  _EditMarketPlaceInfoState createState() => _EditMarketPlaceInfoState();
}

class _EditMarketPlaceInfoState extends State<EditMarketPlaceInfo> {
  String Token = '123456789';

  TextEditingController market_TitleCtl = TextEditingController();
  TextEditingController market_DescCtl = TextEditingController();
  TextEditingController market_AddressCtl = TextEditingController();
  TextEditingController market_ContactnoCtl = TextEditingController();
  TextEditingController market_WebsiteCtl = TextEditingController();

  Future editMarketPlaceInfo() async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse(
            'https://eku-abo.com/api/marketplace/update_marketplace_info.php'),
        body: {
          'token': Token,
          'user_id': userBean.data.id,
          'market_id': '',
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EkuaboString.edit_market_place_info.text.medium
                .size(18)
                .heightTight
                .make()
                .pOnly(left: 16),
            UnderlineWidget().getUnderlineWidget().pOnly(left: 16),
            16.heightBox,
            VxCard(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EkuaboString.market_place_info.text.medium
                    .size(16)
                    .heightTight
                    .make(),
                UnderlineWidget().getUnderlineWidget(),
                Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 10, maxHeight: 40),
                      child: TextFormField(
                        controller: market_TitleCtl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "Market Title",
                            labelStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.secondColor),
                            hintText: "Market Title",
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
                        EkuaboString.uploadLogoProfilePhoto.text.medium
                            .size(11)
                            .make(),
                        10.widthBox,
                        Image.asset(
                          EkuaboAsset.ic_upload,
                          width: 21,
                          height: 14,
                        )
                      ],
                    ),
                    16.heightBox,
                    TextFormField(
                      controller: market_DescCtl,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 5,
                      decoration: InputDecoration(
                          filled: true,
                          alignLabelWithHint: true,
                          labelText: "MarketPlace Description",
                          labelStyle: const TextStyle(
                              fontFamily: EkuaboAsset.CERA_PRO_FONT,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: MyColor.secondColor),
                          hintText: "MarketPlace Description",
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
                    EkuaboString.contact_information.text.medium
                        .size(16)
                        .heightTight
                        .make(),
                    UnderlineWidget().getUnderlineWidget(),
                    16.heightBox,
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: market_AddressCtl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Market address",
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: "Market address(Market Home town)",
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
                        10.widthBox,
                        Expanded(
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: market_ContactnoCtl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: "contact_no",
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: "contact_no",
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
                    20.heightBox,
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: market_WebsiteCtl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: "website",
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: "website",
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
                        10.widthBox,
                        Expanded(
                          flex: 1,
                          child: VxBox().make(),
                        )
                      ],
                    )
                  ],
                )).p(15),
                10.heightBox,
                MaterialButton(
                  minWidth: 170,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: EkuaboString.submit
                      .toUpperCase()
                      .text
                      .color(MyColor.lightestGrey)
                      .make(),
                  color: MyColor.mainColor,
                  height: 45,
                ).objectCenter().pOnly(bottom: 50),
              ],
            ).p(10))
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
      ),
    );
  }
}
