import 'dart:convert';

import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/market_place_controller.dart';
import 'package:ekuabo/model/apimodel/market_place/category_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/pages/market_place.dart';
import 'package:ekuabo/pages/marketplace_listing.dart';

import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/navigationDrawer.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class MyMarketPlace extends StatefulWidget {
  @override
  State<MyMarketPlace> createState() => _MyMarketPlaceState();
}

class _MyMarketPlaceState extends State<MyMarketPlace> {
  String Token = '123456789';
  String market_id = '';
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<MarketPlaceController>();
  Future<CategoryBean> getMarketPlaceCategory;
  void initialize() {
    setState(() {
      getMarketPlaceCategory = MarketPlaceRepository().getCategory();
    });
  }

  Future getmarketid() async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse(
            'https://eku-abo.com/api/marketplace/get_marketplace_info.php'),
        body: {'token': Token, 'user_id': userBean.data.id});
    var Response = jsonDecode(response.body);
    return Response;
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    _con.getMyMarketPlace();
    getmarketid().then((value) {
      setState(() {
        market_id = value['data'][0]['market_id'].toString();
        print(market_id);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketPlaceController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(context,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: MyColor.mainColor,
                ))),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              EkuaboAsset.bottom_image,
              width: double.infinity,
            ).objectBottomLeft(),
            16.heightBox,
            Column(
              children: [
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EkuaboString.marketPlaceListing.text.heightTight
                            .size(18)
                            .medium
                            .make(),
                        UnderlineWidget().getUnderlineWidget()
                      ],
                    ),
                    (market_id.toString() == '0')
                        ? VxCircle(
                            backgroundColor: Colors.grey,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ).onFeedBackTap(() async {
                              Utils().showSnackBar(context,
                                  'Edit MarketplaceInfo First in My Profile');
                            }),
                            shadows: const [
                              BoxShadow(color: Colors.grey, blurRadius: 10)
                            ],
                          ).wh(40, 40)
                        : VxCircle(
                            backgroundColor: MyColor.mainColor,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ).onFeedBackTap(() async {
                              UserBean userbean;
                              userbean = await PrefManager.getUser();
                              print(userbean.data.id);

                              Navigator.pushNamed(
                                      context, EkuaboRoute.postNewListing)
                                  .then((value) {
                                _con.getMyMarketPlace();
                              });
                            }),
                            shadows: const [
                              BoxShadow(
                                  color: MyColor.inactiveColor, blurRadius: 10)
                            ],
                          ).wh(40, 40)
                  ],
                ).pOnly(left: 16, right: 16),
                _con.mymarketPlaces.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          itemBuilder: (ctx, index) {
                            return VxCard(marketlistTile(
                              con: _con,
                              index: index,
                            ))
                                .elevation(5)
                                .withRounded(value: 7)
                                .white
                                .make()
                                .onTap(() {
                              m_id = _con.mymarketPlaces[index].marketplaceId
                                  .toString();
                              print(m_id +
                                  'ppppppppppppppppppppppppppppppppppppppppppp in my market');
                              _homeController.bottomNavigatorKey.currentState
                                  .push(ScaleRoute(page: MarketPlaceListing()))
                                  .then((value) {
                                _con.getMyMarketPlace();
                              });
                              _homeController.navigationQueue.addLast(1);
                            }).pOnly(top: 10, left: 10, right: 10);
                          },
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _con.mymarketPlaces.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3.2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 5),
                        ),
                      )
                    : EkuaboString.no_results_found.text
                        .size(14)
                        .medium
                        .color(Colors.grey)
                        .make()
                        .objectTopLeft()
                        .pOnly(left: 16)
              ],
            ),
          ],
        ),
      ),
      initState: (_) {
        _con.getMyMarketPlace();
      },
    );
  }
}

class marketlistTile extends StatelessWidget {
  const marketlistTile({
    Key key,
    @required MarketPlaceController con,
    @required this.index,
  })  : _con = con,
        super(key: key);

  final MarketPlaceController _con;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                      child: Image.network(
                    _con.mymarketPlaces[index].image[0].image.toString(),
                    fit: BoxFit.cover,
                  )).w(200).h(130).backgroundColor(Colors.red)),
              Expanded(
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              )
            ],
          ),
          "${_con.mymarketPlaces[index].title}"
              .text
              .size(16)
              .medium
              .make()
              .pOnly(left: 10),
          Column(
            children: [
              "${_con.mymarketPlaces[index].categoryName}",
              "${_con.mymarketPlaces[index].subCategoryName}"
            ].map((e) {
              return VxBox(
                      child: e.text.white
                          .size(10)
                          .medium
                          .makeCentered()
                          .pOnly(top: 3, bottom: 3, left: 5, right: 5))
                  .color(MyColor.blackColor.withOpacity(0.4))
                  .withRounded(value: 10)
                  .height(20)
                  .withConstraints(const BoxConstraints(minWidth: 40))
                  .make()
                  .p(2);
            }).toList(),
          ),
          EkuaboString.public.text
              .color(MyColor.mainColor)
              .size(16)
              .medium
              .make()
              .pOnly(left: 10),
          Row(
            children: [
              Image.asset(
                EkuaboAsset.ic_location,
                color: MyColor.mainColor,
                width: 16,
                height: 16,
              ),
              10.widthBox,
              "${_con.mymarketPlaces[index].location}"
                  .text
                  .size(12)
                  .medium
                  .make(),
              16.heightBox,
            ],
          ).pOnly(left: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              "${_con.mymarketPlaces[index].currency_code.toString()}"
                  .text
                  .size(20)
                  .medium
                  .color(MyColor.mainColor)
                  .make(),
              3.widthBox,
              "${_con.marketPlaces[index].price}"
                  .text
                  .size(20)
                  .medium
                  .underline
                  .color(MyColor.mainColor)
                  .make(),
            ],
          )
        ],
      ),
    );
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
