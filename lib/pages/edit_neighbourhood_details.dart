import 'dart:convert';

import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class EditNeighbourhoodDetails extends StatefulWidget {
  @override
  _EditNeighbourhoodDetailsState createState() =>
      _EditNeighbourhoodDetailsState();
}

class _EditNeighbourhoodDetailsState extends State<EditNeighbourhoodDetails> {
  List countries = [];
  List States = [];
  List LGAs = [];
  var SelectedCountry;
  var SelectedState;
  var SelectedLGA;
  String Token = '123456789';
  Future Submit() async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http
        .post(Uri.parse('https://eku-abo.com/api/update_lga.php'), body: {
      'token': Token,
      'user_id': userBean.data.id,
      'country_id': SelectedCountry['CountryId'],
      'state_id': SelectedState['StateID'],
      'lga_id': SelectedLGA['id']
    });
    userBean.data.lga_name = SelectedLGA['lga_name'];
    userBean.data.lgaId = SelectedLGA['id'];
    String jsonString = json.encode(userBean);
    PrefManager.putString(PrefManager.USER_DATA, jsonString);
    var Response = jsonDecode(response.body);
    print(Response);
    print(SelectedLGA['lga_name']);
    UserBean user = await PrefManager.getUser();
  }

  Future getCountry() async {
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/get_country.php'),
        body: {'token': Token});
    var Response = jsonDecode(response.body);
    return Response;
  }

  Future getState(var Country_id) async {
    SelectedCountry = Country_id;
    SelectedState = null;
    SelectedLGA = null;

    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/get_state.php'),
        body: {'token': Token, 'country_id': Country_id['CountryId']});
    var Response = jsonDecode(response.body);
    return Response;
  }

  Future getLga(var State_id) async {
    SelectedState = State_id;
    SelectedLGA = null;
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/get_lga.php'),
        body: {'token': Token, 'state_id': State_id['StateID']});
    var Response = jsonDecode(response.body);
    return Response;
  }

  @override
  void initState() {
    getCountry().then((value) {
      setState(() {
        countries = value['data'];
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcuaboAppBar().getAppBar(context),
      body: VxCard(
        Column(
          children: [
            Form(
              child: Column(
                children: [
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
                            items: countries.map((snapshot) {
                              return new DropdownMenuItem(
                                child: snapshot['countryName']
                                    .toString()
                                    .text
                                    .make(),
                                value: snapshot,
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                print(newVal);

                                getState(newVal).then((value) {
                                  setState(() {
                                    States = value['data'];
                                  });
                                });
                              });
                            },
                            value: SelectedCountry,
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
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))))
                      .height(40)
                      .make(),
                  16.heightBox,
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
                            items: States.map((snapshot) {
                              return new DropdownMenuItem(
                                child: snapshot['stateName']
                                    .toString()
                                    .text
                                    .make(),
                                value: snapshot,
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                print(newVal);

                                getLga(newVal).then((value) {
                                  setState(() {
                                    LGAs = value['data'];
                                  });
                                });
                              });
                            },
                            value: SelectedState,
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
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))))
                      .height(40)
                      .make(),
                  16.heightBox,
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
                            items: LGAs.map((snapshot) {
                              return new DropdownMenuItem(
                                child:
                                    snapshot['lga_name'].toString().text.make(),
                                value: snapshot,
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                print(newVal);
                                SelectedLGA = newVal;
                                print(SelectedCountry.toString() +
                                    SelectedState.toString() +
                                    SelectedLGA.toString());
                                // getLga(newVal.toString()).then((value) {
                                //   setState(() {
                                //     LGAs = value['data'];
                                //   });
                                // });
                              });
                            },
                            value: SelectedLGA,
                            hint: EkuaboString.lga.text
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
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))))
                      .height(40)
                      .make(),
                  16.heightBox,
                ],
              ).p(15),
            ),
            MaterialButton(
              minWidth: 170,
              onPressed: () => Submit(),
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
        ),
      )
          .elevation(5)
          .color(const Color(0xffF5F5F5))
          .shadowColor(const Color(0xff000029))
          .makeCentered()
          .cornerRadius(12)
          .p(10),
    );
  }
}
