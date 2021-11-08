import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/market_place_controller.dart';
import 'package:ekuabo/pages/userShopMarketListing.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

int tag;

class userShopMarketPlace extends StatefulWidget {
  final String user_id;

  const userShopMarketPlace({Key key, @required this.user_id})
      : super(key: key);
  @override
  State<userShopMarketPlace> createState() => _userShopMarketPlaceState();
}

class _userShopMarketPlaceState extends State<userShopMarketPlace> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<MarketPlaceController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketPlaceController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(context),
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
                  ],
                ).pOnly(left: 16, right: 16),
                _con.marketPlaces.isNotEmpty
                    ? Container(
                        constraints: const BoxConstraints(
                            maxHeight: 350, maxWidth: double.infinity),
                        child: ListView.builder(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserMarketPlaceDetails(
                                            market_id: _con.marketPlaces[index]
                                                .marketplaceId,
                                          )));
                              // _homeController.bottomNavigatorKey.currentState
                              //     .pushNamed(EkuaboRoute.marketPlaceListing);
                              // _homeController.navigationQueue.addLast(1);
                            }).pOnly(top: 10, left: 10, right: 10);
                          },
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _con.marketPlaces.length,
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
        _con.getShopMarketPlace(widget.user_id);
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
    tag = index;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        16.heightBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxBox(
                    child: Hero(
              tag: "${tag}",
              child: Image.network(
                _con.marketPlaces[index].image[0].image,
                fit: BoxFit.cover,
                width: 134,
                height: 134,
              ),
            ))
                .width(134)
                .height(134)
                .bottomLeftRounded(value: 12)
                .makeCentered()
                .pOnly(left: 20),
            10.widthBox,
            const Icon(
              Icons.more_vert,
              color: Colors.black,
            )
          ],
        ),
        16.heightBox,
        "${_con.marketPlaces[index].title}"
            .text
            .size(16)
            .medium
            .make()
            .pOnly(left: 10),
        16.heightBox,
        Row(
          children: [
            "${_con.marketPlaces[index].categoryName}",
            "${_con.marketPlaces[index].subCategoryName}"
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
                .pOnly(left: 10);
          }).toList(),
        ),
        16.heightBox,
        EkuaboString.public.text
            .color(MyColor.mainColor)
            .size(16)
            .medium
            .make()
            .pOnly(left: 10),
        10.heightBox,
        Row(
          children: [
            Image.asset(
              EkuaboAsset.ic_location,
              color: MyColor.mainColor,
              width: 16,
              height: 16,
            ),
            10.widthBox,
            "${_con.marketPlaces[index].location}".text.size(12).medium.make(),
            16.heightBox,
          ],
        ).pOnly(left: 10),
        10.heightBox,
        Row(
          children: [
            "\$".text.size(20).medium.color(MyColor.mainColor).make(),
            3.widthBox,
            "${_con.marketPlaces[index].price}"
                .text
                .size(20)
                .medium
                .underline
                .color(MyColor.mainColor)
                .make(),
          ],
        ).pOnly(left: MediaQuery.of(context).size.width * 0.18, bottom: 10)
      ],
    );
  }
}
