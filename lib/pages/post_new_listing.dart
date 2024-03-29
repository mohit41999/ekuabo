import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:ekuabo/controller/add_marketplace_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/amount_seperator.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/currency_symbol.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  PickedFile mediaFile;
  Future getImage(context) {
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
                        setState(() {
                          _imgFromGallery();
                        });

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      setState(() {
                        _imgFromCamera();
                      });

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
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      mediaFile = image;
    });
  }

  Future _imgFromGallery() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      mediaFile = image;
    });
  }
  // Future getImage() async {
  //   mediaFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  // }

  Future postListing() async {
    var loader = ProgressView(context);
    loader.show();
    userBean = await PrefManager.getUser();
    print(mediaFile.toString());
    if (mediaFile.toString() != null.toString()) {
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
      request.fields['currency_code'] = _con.currency_ISO;
      var pic = await http.MultipartFile.fromPath("image[]", mediaFile.path);
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
            'currency_code': _con.currency_ISO,
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
        appBar: EcuaboAppBar(),
        drawer: CommonNavigationDrawer(),
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
                            getImage(context).then((value) {
                              setState(() {});
                            });
                          });
                        },
                        child: Row(
                          children: [
                            (mediaFile == null)
                                ? EkuaboString.upload_listing_image.text.medium
                                    .size(11)
                                    .make()
                                : mediaFile.path
                                    .substring(
                                        mediaFile.path.lastIndexOf('/') + 1,
                                        mediaFile.path.length)
                                    .text
                                    .medium
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
                                  theme: CurrencyPickerThemeData(
                                    titleTextStyle: GoogleFonts.roboto(),
                                    subtitleTextStyle: GoogleFonts.roboto(),
                                  ),
                                  context: context,
                                  showFlag: true,
                                  showCurrencyName: true,
                                  showCurrencyCode: true,
                                  favorite: [],
                                  onSelect: (Currency currency) {
                                    print(
                                        'Select currency ISO: ${currency.code}');
                                    print(
                                        'Select currency : ${currency.symbol}');

                                    setState(() {
                                      _con.currency_ISO =
                                          currency.code.toString();
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
                                      Text(
                                        _con.currency_code,
                                        style: GoogleFonts.roboto(fontSize: 20),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  )),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       showCountryPicker(
                          //         context: context,
                          //         //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                          //
                          //         //Optional. Shows phone code before the country name.
                          //         showPhoneCode: true,
                          //         onSelect: (Country country) {
                          //           print(
                          //               'Select country: ${currency(context, country.name).currencySymbol}');
                          //         },
                          //         // Optional. Sets the theme for the country list picker.
                          //         countryListTheme: CountryListThemeData(
                          //           // Optional. Sets the border radius for the bottomsheet.
                          //           borderRadius: BorderRadius.only(
                          //             topLeft: Radius.circular(40.0),
                          //             topRight: Radius.circular(40.0),
                          //           ),
                          //           // Optional. Styles the search field.
                          //           inputDecoration: InputDecoration(
                          //             labelText: 'Search',
                          //             hintText: 'Start typing to search',
                          //             prefixIcon: const Icon(Icons.search),
                          //             border: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                 color: const Color(0xFF8C98A8)
                          //                     .withOpacity(0.2),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //     child: Container(
                          //         height: 40,
                          //         decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             border:
                          //                 Border.all(color: MyColor.mainColor),
                          //             borderRadius: BorderRadius.circular(7)),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text(
                          //               _con.currency_code,
                          //               style: GoogleFonts.roboto(fontSize: 20),
                          //             ),
                          //             Icon(Icons.arrow_drop_down),
                          //           ],
                          //         )),
                          //   ),
                          // ),
                          5.widthBox,
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                inputFormatters: [
                                  ThousandsSeparatorInputFormatter()
                                ],
                                controller: _con.productpricecontroller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: EkuaboString.enter_product_price
                                            .toString() +
                                        _con.currency_code,
                                    labelStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: MyColor.secondColor),
                                    hintText: EkuaboString.enter_product_price
                                            .toString() +
                                        _con.currency_code,
                                    hintStyle: GoogleFonts.roboto(
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
