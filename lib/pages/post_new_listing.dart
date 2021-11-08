import 'dart:convert';

import 'package:ekuabo/controller/add_marketplace_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:currency_picker/currency_picker.dart';

class PostNewListing extends StatefulWidget {
  @override
  State<PostNewListing> createState() => _PostNewListingState();
}

class _PostNewListingState extends State<PostNewListing> {
  final _con = Get.find<AddMarketPlaceController>();

  UserBean userBean;

  String _value = 'public';
  var image;
  Future getImage() async {
    image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  }

  Future postListing() async {
    var loader = ProgressView(context);
    loader.show();
    userBean = await PrefManager.getUser();
    print(image.toString());
    if (image.toString() != null.toString()) {
      var request = http.MultipartRequest("POST",
          Uri.parse("https://eku-abo.com/api/marketplace/add_marketplace.php"));
      request.fields['user_id'] = userBean.data.id;
      request.fields['token'] = '123456789';
      request.fields['title'] = _con.titlecontroller.text;
      request.fields['category_id'] = _con.selectedCategory.id.toString();
      request.fields['sub_category_id'] =
          _con.selectedSubCategory.id.toString();
      request.fields['description'] = _con.listdesccontroller.text;
      request.fields['location'] = _con.listlocationcontroller.text;
      request.fields['price'] = _con.productpricecontroller.text;
      request.fields['email'] = _con.emailcontroller.text;
      request.fields['mobile_no'] = _con.mobilenumbercontroller.text;
      request.fields['neigborhood'] = _value;
      request.fields['currency_code'] = _con.currency_code;
      var pic = await http.MultipartFile.fromPath("image[]", image.path);
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
      loader.dismiss();
      Navigator.pop(context);
    } else {
      var loader = ProgressView(context);
      loader.show();
      var response = await http.post(
          Uri.parse('https://eku-abo.com/api/marketplace/add_marketplace.php'),
          body: {
            'token': '123456789',
            'user_id': userBean.data.id,
            'title': _con.titlecontroller.text.toString(),
            'category_id': _con.selectedCategory.id.toString(),
            'sub_category_id': _con.selectedSubCategory.id.toString(),
            'description': _con.listdesccontroller.text.toString(),
            'location': _con.listlocationcontroller.text.toString(),
            'price': _con.productpricecontroller.text.toString(),
            'email': _con.emailcontroller.text.toString(),
            'mobile_no': _con.mobilenumbercontroller.text.toString(),
            'neigborhood': _value.toString(),
            'currency_code': _con.currency_code,
          });
      var Response = jsonDecode(response.body);
      print(Response);
      loader.dismiss();
      print(userBean.data.id +
          ' ' +
          _con.titlecontroller.text +
          ' ' +
          _con.selectedCategory.id.toString() +
          ' ' +
          _con.selectedSubCategory.id.toString() +
          ' ' +
          _con.listdesccontroller.text +
          ' ' +
          _con.listlocationcontroller.text +
          ' ' +
          _con.productpricecontroller.text +
          ' ' +
          _con.emailcontroller.text +
          ' ' +
          _con.mobilenumbercontroller.text +
          ' ' +
          _value);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _con.mobilenumbercontroller.clear();
    _con.emailcontroller.clear();
    _con.productpricecontroller.clear();
    _con.listlocationcontroller.clear();
    _con.listdesccontroller.clear();
    _con.titlecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMarketPlaceController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(context),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.heightBox,
            EkuaboString.post_a_new_listing.text.medium
                .size(16)
                .heightTight
                .make()
                .pOnly(left: 16),
            UnderlineWidget().getUnderlineWidget().pOnly(left: 16),
            16.heightBox,
            VxCard(
              Column(
                children: [
                  Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Listing Title
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minHeight: 10, maxHeight: 40),
                        child: TextFormField(
                          controller: _con.titlecontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              labelText: EkuaboString.enter_listing_title,
                              labelStyle: const TextStyle(
                                  fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: MyColor.secondColor),
                              hintText: EkuaboString.enter_listing_title,
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
                      // Select Category
                      VxBox(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: _con.categories.map((category) {
                              return DropdownMenuItem(
                                child: category.cateName.text.make(),
                                value: category,
                              );
                            }).toList(),
                            hint: EkuaboString.select_listing_category.text
                                .size(14)
                                .color(Colors.grey.withOpacity(0.6))
                                .make(),
                            icon: Image.asset(
                              EkuaboAsset.ic_down_arrow,
                              width: 15,
                              height: 16,
                            ),
                            isExpanded: true,
                            value: _con.selectedCategory,
                            onChanged: (value) {
                              _con.selectedCategory = value;
                              _con.getSubCategory(context, value.id);
                            },
                          ),
                        ).p(10),
                      )
                          .withDecoration(BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7))))
                          .height(40)
                          .make(),
                      16.heightBox,
                      // Select Sub Listing Category
                      VxBox(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: _con.subCategories.map((subCategory) {
                              return DropdownMenuItem(
                                child: subCategory.subCateName.text.make(),
                                value: subCategory,
                              );
                            }).toList(),
                            hint: EkuaboString.select_listing_sub_category.text
                                .size(14)
                                .color(Colors.grey.withOpacity(0.6))
                                .make(),
                            icon: Image.asset(
                              EkuaboAsset.ic_down_arrow,
                              width: 15,
                              height: 16,
                            ),
                            isExpanded: true,
                            value: _con.selectedSubCategory,
                            onChanged: (value) {
                              _con.selectedSubCategory = value;
                              _con.update();
                            },
                          ),
                        ).p(10),
                      )
                          .withDecoration(BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7))))
                          .height(40)
                          .make(),
                      16.heightBox,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getImage();
                          });
                        },
                        child: Row(
                          children: [
                            EkuaboString.upload_listing_image.text.medium
                                .size(11)
                                .make(),
                            10.widthBox,
                            Image.asset(
                              EkuaboAsset.ic_upload,
                              width: 16,
                              height: 16,
                            )
                          ],
                        ),
                      ),
                      16.heightBox,
                      // Enter Listing Location
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minHeight: 10, maxHeight: 40),
                        child: TextFormField(
                          controller: _con.listlocationcontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              labelText: EkuaboString.enter_listing_location,
                              labelStyle: const TextStyle(
                                  fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: MyColor.secondColor),
                              hintText: EkuaboString.enter_listing_location,
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
                        constraints:
                            const BoxConstraints(minHeight: 10, maxHeight: 150),
                        child: TextFormField(
                          controller: _con.listdesccontroller,
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: 5,
                          decoration: InputDecoration(
                              filled: true,
                              labelText: EkuaboString.enter_listing_description,
                              labelStyle: const TextStyle(
                                  fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: MyColor.secondColor),
                              hintText: EkuaboString.enter_listing_description,
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

                      // Enter Product Price
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                showCurrencyPicker(
                                  context: context,
                                  showFlag: true,
                                  showCurrencyName: true,
                                  showCurrencyCode: true,
                                  favorite: [],
                                  onSelect: (Currency currency) {
                                    print(
                                        'Select currency: ${currency.symbol}');
                                    setState(() {
                                      _con.currency_code =
                                          currency.symbol.toString();
                                    });
                                  },
                                );
                              },
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: MyColor.mainColor),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      (_con.currency_code == '')
                                          ? Text(
                                              '\$',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          : Text(
                                              _con.currency_code,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  )),
                            ),
                          ),
                          5.widthBox,
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                controller: _con.productpricecontroller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: EkuaboString.enter_product_price
                                            .toString() +
                                        _con.currency_code,
                                    labelStyle: const TextStyle(
                                        fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: MyColor.secondColor),
                                    hintText: EkuaboString.enter_product_price
                                            .toString() +
                                        _con.currency_code,
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
                          ),
                        ],
                      ),
                      16.heightBox,
                      // Email
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minHeight: 10, maxHeight: 40),
                        child: TextFormField(
                          controller: _con.emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              filled: true,
                              labelText: EkuaboString.email,
                              labelStyle: const TextStyle(
                                  fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: MyColor.secondColor),
                              hintText: 'Lorem.ipsum@lorem.com',
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
                      // Mobile Number
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minHeight: 10, maxHeight: 40),
                        child: TextFormField(
                          controller: _con.mobilenumbercontroller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              filled: true,
                              labelText: EkuaboString.mobile,
                              labelStyle: const TextStyle(
                                  fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: MyColor.secondColor),
                              hintText: '+911234567890',
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
                      // Select Neighbourhood
                      VxBox(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'private',
                                child: Text('private'),
                              ),
                              DropdownMenuItem(
                                value: 'public',
                                child: Text('public'),
                              ),
                            ],
                            hint: EkuaboString.select_neighbourhood.text
                                .size(14)
                                .color(Colors.grey.withOpacity(0.6))
                                .make(),
                            icon: Image.asset(
                              EkuaboAsset.ic_down_arrow,
                              width: 15,
                              height: 16,
                            ),
                            isExpanded: true,
                          ),
                        ).p(10),
                      )
                          .withDecoration(BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7))))
                          .height(40)
                          .make(),
                    ],
                  )).p(15),
                  MaterialButton(
                    minWidth: 170,
                    onPressed: () {
                      postListing().then((value) => _con.clearcontrollers());
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
              ).p(10),
            )
                .elevation(7)
                .withRounded(value: 7)
                .color(
                  MyColor.lightGrey,
                )
                .make()
                .pOnly(left: 16, right: 16),
            Image.asset(
              EkuaboAsset.bottom_image,
              width: double.infinity,
            )
          ],
        )),
      ),
      initState: (_) => _con.getCategory(),
    );
  }
}
