import 'package:country_picker/country_picker.dart';
import 'package:ekuabo/controller/sign_up_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country/flutter_country.dart' as MyCountry;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatelessWidget {
  final _con = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_con.countries.value.isEmpty) {
        _con.getCountry(context);
      }
    });
    return Obx(() => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  30.heightBox,
                  EkuaboString.signUp.text.medium
                      .size(28)
                      .color(const Color(0xff333232))
                      .makeCentered(),
                  30.heightBox,
                  VxCard(Column(
                    children: [
                      Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Select Country
                          VxBox(
                            child: Row(
                              children: [
                                12.widthBox,
                                Image.asset(
                                  EkuaboAsset.ic_location,
                                  width: 15,
                                  height: 16,
                                ),
                                12.widthBox,
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: _con.countries.value.map((country) {
                                      return DropdownMenuItem(
                                        child: country.countryName.text.make(),
                                        value: country,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _con.getState(value);
                                    },
                                    value: _con.selectedCountryBean,
                                    hint: EkuaboString.selectCountry.text
                                        .size(14)
                                        .color(Colors.grey.withOpacity(0.6))
                                        .make(),
                                    icon: Image.asset(
                                      EkuaboAsset.ic_down_arrow,
                                      width: 15,
                                      height: 16,
                                    ),
                                    isExpanded: true,
                                  ).w(MediaQuery.of(context).size.width - 120),
                                )
                              ],
                            ),
                          )
                              .withDecoration(BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))))
                              .height(40)
                              .make(),
                          16.heightBox,
                          // Select State
                          VxBox(
                            child: Row(
                              children: [
                                12.widthBox,
                                Image.asset(
                                  EkuaboAsset.ic_location,
                                  width: 15,
                                  height: 16,
                                ),
                                12.widthBox,
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: _con.states.value.map((state) {
                                      return DropdownMenuItem(
                                        child: state.stateName.text.make(),
                                        value: state,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _con.getLga(value);
                                    },
                                    value: _con.selectedState,
                                    hint: EkuaboString.selectState.text
                                        .size(14)
                                        .color(Colors.grey.withOpacity(0.6))
                                        .make(),
                                    icon: Image.asset(
                                      EkuaboAsset.ic_down_arrow,
                                      width: 15,
                                      height: 16,
                                    ),
                                    isExpanded: true,
                                  ).w(MediaQuery.of(context).size.width - 120),
                                )
                              ],
                            ),
                          )
                              .withDecoration(BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))))
                              .height(40)
                              .make(),
                          16.heightBox,
                          // Select LGA
                          VxBox(
                            child: Row(
                              children: [
                                12.widthBox,
                                Image.asset(
                                  EkuaboAsset.ic_location,
                                  width: 15,
                                  height: 16,
                                ),
                                12.widthBox,
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: _con.lgas.value.map((lga) {
                                      return DropdownMenuItem(
                                        child: lga.lgaName.text.make(),
                                        value: lga,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _con.selectedLga = value;
                                      Get.appUpdate();
                                    },
                                    value: _con.selectedLga,
                                    hint: EkuaboString.lga.text
                                        .color(Colors.grey.withOpacity(0.6))
                                        .make(),
                                    icon: Image.asset(
                                      EkuaboAsset.ic_down_arrow,
                                      width: 15,
                                      height: 16,
                                    ),
                                    isExpanded: true,
                                  ).w(MediaQuery.of(context).size.width - 120),
                                )
                              ],
                            ),
                          )
                              .withDecoration(BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))))
                              .height(40)
                              .make(),
                          16.heightBox,
                          // Email
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.emailCtl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: EkuaboString.email,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  prefixIcon: IconButton(
                                      icon: Image.asset(
                                        EkuaboAsset.ic_email,
                                        width: 15.0,
                                        height: 12.0,
                                      ),
                                      onPressed: null),
                                  hintText: EkuaboString.email,
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
                          // Enter Home Address
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.homeAddressCtl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: EkuaboString.enterHomeAddress,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  prefixIcon: IconButton(
                                      icon: Image.asset(
                                        EkuaboAsset.ic_location,
                                        width: 15.0,
                                        height: 16.0,
                                      ),
                                      onPressed: null),
                                  hintText: EkuaboString.enterHomeAddress,
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
                          // Enter Full Name
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.fullNameCtl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: EkuaboString.enterFullName,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  prefixIcon: IconButton(
                                      icon: Image.asset(
                                        EkuaboAsset.ic_user,
                                        width: 15.0,
                                        height: 12.0,
                                      ),
                                      onPressed: null),
                                  hintText: EkuaboString.enterFullName,
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
                          //Password
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 40),
                            child: TextFormField(
                              controller: _con.passwordCtl,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _con.hide_password.value,
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    icon: Image.asset(
                                      EkuaboAsset.ic_key,
                                      width: 15.0,
                                      height: 14.0,
                                    ),
                                    onPressed: null,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _con.hide_password.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 16,
                                        color:
                                            MyColor.blackColor.withOpacity(0.8),
                                      ),
                                      onPressed: () {
                                        _con.hide_password.value =
                                            !_con.hide_password.value;
                                      }),
                                  filled: true,
                                  labelText: EkuaboString.password,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: EkuaboString.password,
                                  hintStyle: const TextStyle(
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
                          //Confirm Password
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 40),
                            child: TextFormField(
                              controller: _con.cPasswordCtl,
                              keyboardType: TextInputType.text,
                              obscureText: _con.hide_password2.value,
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    icon: Image.asset(
                                      EkuaboAsset.ic_key,
                                      width: 15.0,
                                      height: 14.0,
                                    ),
                                    onPressed: null,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _con.hide_password2.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 16,
                                        color:
                                            MyColor.blackColor.withOpacity(0.8),
                                      ),
                                      onPressed: () {
                                        _con.hide_password2.value =
                                            !_con.hide_password2.value;
                                      }),
                                  filled: true,
                                  labelText: EkuaboString.confirmPassword,
                                  labelStyle: const TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: EkuaboString.confirmPassword,
                                  hintStyle: const TextStyle(
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
                          //Mobile Number
                          VxBox(
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    10.widthBox,
                                    SvgPicture.network(
                                      _con.selectedCountry.value.flags
                                              .isNotEmpty
                                          ? _con.selectedCountry.value
                                                  .flags[0] ??
                                              ''
                                          : '',
                                      width: 20,
                                      height: 16,
                                    ),
                                    10.widthBox,
                                    "+${_con.selectedCountry.value.callingCodes[0]}"
                                        .text
                                        .medium
                                        .size(11)
                                        .make(),
                                    5.widthBox,
                                    Image.asset(
                                      EkuaboAsset.ic_down_arrow,
                                      width: 19,
                                      height: 6,
                                    ),
                                    3.widthBox,
                                    VxBox()
                                        .width(1)
                                        .height(40)
                                        .color(Colors.grey)
                                        .make(),
                                  ],
                                ).onFeedBackTap(() {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode:
                                        true, // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      for (MyCountry.Country myCountry
                                          in _con.countryList) {
                                        if (myCountry.callingCodes[0] ==
                                            country.phoneCode) {
                                          _con.selectedCountry.value =
                                              myCountry;
                                          break;
                                        }
                                      }
                                      // _con.update();
                                    },
                                  );
                                }),
                                10.widthBox,
                                TextFormField(
                                  controller: _con.mobileCtl,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    /*labelText: EkuaboString.mobile,
                                labelStyle: TextStyle(
                                    fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    color: MyColor.secondColor),*/
                                    hintText: '123-456-7890',
                                    hintStyle: TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                    fillColor: Colors.white,
                                    /*border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        width: 1, color: MyColor.mainColor))*/
                                  ),
                                ).w40(context),
                              ],
                            ),
                          )
                              .withDecoration(BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))))
                              .height(40)
                              .make(),
                          16.heightBox,
                        ],
                      )).p(15),
                      MaterialButton(
                        minWidth: 170,
                        onPressed: () => _con.callSignUpApi(context),
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
                      .shadowColor(const Color(0xff000029))
                      .makeCentered()
                      .cornerRadius(12)
                      .p(10),
                  16.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EkuaboString.alreadyMember.text.medium.size(11).make(),
                      10.widthBox,
                      EkuaboString.signIn.text
                          .color(MyColor.mainColor)
                          .medium
                          .size(11)
                          .make()
                          .onTap(() => Get.back()),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EkuaboString.verificationLeft.text.medium.size(11).make(),
                      10.widthBox,
                      EkuaboString.clickHere.text
                          .color(MyColor.mainColor)
                          .medium
                          .size(11)
                          .make()
                          .onTap(
                              () /*=>Get.toNamed(EkuaboRoute.otpVerificationScreen)*/ {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
// void _showCountryPickerBottomSheet(BuildContext context)async
// {
//   Log.info("Hello");
//    showModalBottomSheet<void>(
//        shape:const RoundedRectangleBorder(
//          borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
//        ),
//        context: context,builder:(ctx){
//     return ListView.builder(itemBuilder: (ctx,index){
//       return Column(
//         children: [
//           ListTile(
//             leading: SvgPicture.network(_con.countryList.value[index].flags[0],width: 40,height: 20,),
//             title: _con.countryList.value[index].name.text.make(),
//             onTap: (){
//               _con.selectedCountry.value=_con.countryList.value[index];
//               Get.back();
//             },
//           ),
//           VxBox().height(0.6).color(Colors.grey).width(double.infinity).make()
//         ],
//       ).p(10);
//     });
//   });
// }

}
