import 'package:ekuabo/model/apimodel/market_place/category_bean.dart';
import 'package:ekuabo/model/apimodel/market_place/sub_category_bean.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/pages/search_panel.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class NavigationDrawer extends StatefulWidget {
  Future<CategoryBean> category;

  NavigationDrawer(this.category);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool toggle = false;
  Future<SubCategoryBean> subcategory;
  SubCategoryBean sc;
  int currentindex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          width: 250,
          height: double.maxFinite,
          color: Colors.white,
          child: FutureBuilder<CategoryBean>(
            future: widget.category,
            builder: (context, snapshot) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          (index == 0)
                              ? MaterialButton(
                                  color: MyColor.mainColor,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SearchPanel(
                                                Category: '',
                                                SubCategory: '',
                                                CategoryId: '',
                                                SubCategoryId: '')));
                                  },
                                  child: Text(
                                    'SearchPanel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Container(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                sc = null;
                                currentindex = index;

                                subcategory = MarketPlaceRepository()
                                    .getSubCategory({
                                  'category_id':
                                      '${snapshot.data.data[index].id}'
                                }).then((value) {
                                  setState(() {
                                    sc = value;
                                    print(sc.toString() + 'llllllllllllll');
                                  });
                                });
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data.data[index].cateName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                (sc != null && currentindex == index)
                                    ? IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            sc = null;
                                          });
                                        },
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          (currentindex == index)
                              ? (sc == null)
                                  ? Container()
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: sc.data.length,
                                      itemBuilder: (context, ind) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (cpontext) =>
                                                              SearchPanel(
                                                                Category: snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .cateName,
                                                                SubCategory: sc
                                                                    .data[ind]
                                                                    .subCateName,
                                                                CategoryId:
                                                                    snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .id,
                                                                SubCategoryId:
                                                                    sc.data[ind]
                                                                        .id,
                                                              )));
                                                },
                                                child: Text(
                                                  '${sc.data[ind].subCateName}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                              : Container(),
                          UnderlineWidget().getUnderlineWidget()
                        ],
                      ),
                    );
                  });
            },
          )),
    );
  }
}
