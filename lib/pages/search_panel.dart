import 'dart:convert';

import 'package:ekuabo/model/apimodel/market_place/searchMarketplaceModel.dart';
import 'package:ekuabo/model/apimodel/searchgroup/searchgroupmodel.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/network/repository/searchgroupservices.dart';
import 'package:ekuabo/pages/search_group_page.dart';
import 'package:ekuabo/pages/userShopMarket.dart';
import 'package:ekuabo/pages/userShopMarketListing.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchPanel extends StatefulWidget {
  final String Category;
  final String CategoryId;
  final String SubCategoryId;
  final String SubCategory;
  const SearchPanel(
      {Key key,
      @required this.Category,
      @required this.SubCategory,
      @required this.CategoryId,
      @required this.SubCategoryId})
      : super(key: key);

  @override
  _SearchPanelState createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  String CategoryId;
  String SubCategoryId;
  String Category;
  String SubCategory;

  TextEditingController searchController = TextEditingController();
  Future<SearchMarketplaceModel> searchmodel;
  String shopuserid;

  UserBean userBean;
  TextEditingController _username = TextEditingController();
  Future getListingid(String marketplace_id) async {
    userBean = await PrefManager.getUser();
    var response = await http.post(
      Uri.parse('https://eku-abo.com/api/marketplace/marketplace_details.php'),
      body: {
        'token': '123456789',
        'user_id': userBean.data.id,
        'marketplace_id': marketplace_id
      },
    );
    var Response = jsonDecode(response.body);
    shopuserid = Response['data'][0]['user_details']['user_id'];
  }

  Future initialize() async {
    setState(() {
      CategoryId = widget.CategoryId;
      SubCategoryId = widget.SubCategoryId;
      Category = widget.Category;
      SubCategory = widget.SubCategory;
    });
  }

  @override
  void initState() {
    initialize();
    searchmodel = SearchGroupServices().searchMarketplace(
        search_keyword: searchController.text,
        category_id: widget.CategoryId,
        sub_category_id: widget.SubCategoryId,
        filter: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search Panel',
                    style: TextStyle(
                        color: MyColor.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  MaterialButton(
                    color: Color(0xff531EE4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchGroup()));
                    },
                    child: Text(
                      'Search Group',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              UnderlineWidget().getUnderlineWidget(),
              SizedBox(
                height: 30,
              ),
              Container(
                color: Color(0xffF5F5F5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => GETDATA(true, ''),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                    child: (Category == '')
                                        ? Text("   Select Category   ")
                                        : Text("  " + Category + "  ")),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => GETDATA(false, CategoryId),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                    child: (SubCategory == '')
                                        ? Text("   Select Sub Category   ")
                                        : Text("  " + SubCategory + "  ")),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              height: 40, width: double.infinity),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchmodel = SearchGroupServices()
                                    .searchMarketplace(
                                        search_keyword: searchController.text,
                                        category_id: CategoryId,
                                        sub_category_id: SubCategoryId,
                                        filter: '');
                              });
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                hintText: 'Search by group name keyword',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0x70707061), width: 10),
                                    borderRadius: BorderRadius.circular(40)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40))),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            color: Color(0xff531EE4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () {
                              setState(() {
                                searchmodel = SearchGroupServices()
                                    .searchMarketplace(
                                        search_keyword: searchController.text,
                                        category_id: CategoryId,
                                        sub_category_id: SubCategoryId,
                                        filter: '');
                              });
                            },
                            child: Text(
                              'Search',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Color(0xff531EE4),
                            onPressed: () {
                              searchController.clear();
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<SearchMarketplaceModel>(
                    future: searchmodel,
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      return (snapshot.hasData)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 2,
                                              offset: Offset(1, 1))
                                        ]),
                                    height: 230,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 120,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data
                                                              .data[index]
                                                              .image[0]
                                                              .image),
                                                      fit: BoxFit.contain)),
                                            ),
                                            Container(
                                              height: 120,
                                              width: 200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            snapshot
                                                                .data
                                                                .data[index]
                                                                .title
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border:
                                                                  Border.all(
                                                                      width:
                                                                          0.1)),
                                                          child: Center(
                                                            child: Text(
                                                              " " +
                                                                  snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .categoryName +
                                                                  " ",
                                                              style: TextStyle(
                                                                  fontSize: 11),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    IconRow(
                                                      icon: Icons.email,
                                                      data: snapshot.data
                                                          .data[index].email,
                                                      iconColor: Colors.red,
                                                    ),
                                                    IconRow(
                                                      data: snapshot
                                                          .data
                                                          .data[index]
                                                          .contactNumber,
                                                      icon: Icons.phone,
                                                      iconColor: Colors.green,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(snapshot.data.data[index]
                                            .listingDescription),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 30),
                                          child: MaterialButton(
                                            onPressed: () {
                                              getListingid(snapshot
                                                      .data
                                                      .data[index]
                                                      .marketplaceId)
                                                  .then((value) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserMarketPlaceDetails(
                                                              market_id: snapshot
                                                                  .data
                                                                  .data[index]
                                                                  .marketplaceId,
                                                            )));
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: MyColor.mainColor),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'View',
                                              style: TextStyle(
                                                  color: MyColor.mainColor),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Container();
                      // : ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: snapshot.data.data.length,
                      //     itemBuilder: (context, index) {
                      //       return Text(
                      //           snapshot.data.data[index].title);
                      //     })
                      // }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future GETDATA(bool bool, String cat_id) async {
    List list;
    await (bool)
        ? MarketPlaceRepository().getCategory().then((value) {
            setState(() {
              list = value.data;
              print('llllll');
              print(value.data);
              AlertBox(list, bool);
            });
          })
        : MarketPlaceRepository()
            .getSubCategory({'category_id': cat_id}).then((value) {
            setState(() {
              list = value.data;
              print('llllll');
              print(value.data);

              AlertBox(list, bool);
            });
          });
  }

  AlertBox(List data, bool bool) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                (bool) ? Text('Select Category') : Text('Select Subcategory'),
            content: Container(
              color: Colors.white,
              height: 400,
              child: Container(
                height: 200,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              (bool)
                                  ? CategoryId = data[index].id
                                  : SubCategoryId = data[index].id;

                              (bool)
                                  ? Category = data[index].cateName
                                  : SubCategory = data[index].subCateName;
                            });

                            Navigator.pop(context);
                          },
                          child: (bool)
                              ? Text(data[index].cateName)
                              : Text(data[index].subCateName));
                    }),
              ),
            ),
          );
        });
  }
}

class IconRow extends StatelessWidget {
  final String data;
  final IconData icon;
  final Color iconColor;

  const IconRow({
    Key key,
    @required this.data,
    @required this.icon,
    @required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              icon,
              size: 18,
              color: iconColor.withOpacity(0.7),
            ),
          ),
          Expanded(
            child: Text(
              '${data}',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
