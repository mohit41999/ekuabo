import 'package:ekuabo/controller/transaction_history_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TransactionHistory extends StatelessWidget {
  final _con = Get.find<TransactionHistoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(context),
      body: GetBuilder<TransactionHistoryController>(
        builder: (_) => Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EkuaboString.transaction_history.text
                      .size(16)
                      .medium
                      .heightTight
                      .make()
                      .pOnly(left: 10),
                  UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
                  16.heightBox,
                  _con.transactions.isEmpty
                      ? EkuaboString.no_results_found.text
                          .color(MyColor.blackColor)
                          .size(10)
                          .make()
                          .pOnly(left: 10)
                      : ListView.builder(
                          itemBuilder: (context, index) => VxCard(VxBox(
                                      child: Column(
                            children: [
                              Row(
                                children: [
                                  10.widthBox,
                                  Expanded(
                                    flex: 1,
                                    child: EkuaboString
                                        .transactionId.text.medium
                                        .size(11)
                                        .color(MyColor.blackColor)
                                        .make(),
                                  ),
                                  VxBox()
                                      .color(MyColor.blackColor)
                                      .width(0.4)
                                      .height(40)
                                      .make(),
                                  10.widthBox,
                                  Expanded(
                                    flex: 1,
                                    child: _con.transactions[index]
                                        .transactionId.text.medium
                                        .color(
                                            MyColor.blackColor.withOpacity(0.6))
                                        .size(11)
                                        .make(),
                                  ),
                                ],
                              ),
                              VxBox()
                                  .color(MyColor.blackColor)
                                  .width(double.infinity)
                                  .height(0.4)
                                  .make(),
                              Row(
                                children: [
                                  10.widthBox,
                                  Expanded(
                                    flex: 1,
                                    child: EkuaboString
                                        .transactionDate.text.medium
                                        .size(11)
                                        .color(MyColor.blackColor)
                                        .make(),
                                  ),
                                  VxBox()
                                      .color(MyColor.blackColor)
                                      .width(0.4)
                                      .height(40)
                                      .make(),
                                  10.widthBox,
                                  Expanded(
                                    flex: 1,
                                    child: _con.transactions[index]
                                        .transactionDate.text.medium
                                        .color(
                                            MyColor.blackColor.withOpacity(0.6))
                                        .size(11)
                                        .make(),
                                  ),
                                ],
                              ),
                              VxBox()
                                  .color(MyColor.blackColor)
                                  .width(double.infinity)
                                  .height(0.4)
                                  .make(),
                              Row(
                                children: [
                                  10.widthBox,
                                  Expanded(
                                    flex: 1,
                                    child: EkuaboString.amount.text.medium
                                        .size(11)
                                        .color(MyColor.blackColor)
                                        .make(),
                                  ),
                                  VxBox()
                                      .color(MyColor.blackColor)
                                      .width(0.4)
                                      .height(40)
                                      .make(),
                                  10.widthBox,
                                  Expanded(
                                    flex: 1,
                                    child: _con
                                        .transactions[index].amount.text.medium
                                        .color(
                                            MyColor.blackColor.withOpacity(0.6))
                                        .size(11)
                                        .make(),
                                  ),
                                ],
                              ),
                            ],
                          ))
                                  .withRounded(value: 7)
                                  .white
                                  .border(color: MyColor.blackColor, width: 0.4)
                                  .make()
                                  .p(20))
                              .elevation(7)
                              .withRounded(value: 10)
                              .color(MyColor.lightGrey)
                              .make()
                              .pOnly(top: 16, left: 16, right: 16),
                          itemCount: _con.transactions.length,
                          shrinkWrap: true,
                        )
                ],
              ),
            ),
            Image.asset(
              EkuaboAsset.bottom_image,
              width: double.infinity,
            ).objectBottomLeft()
          ],
        ),
        initState: (_) {
          Get.parameters = {EkuaboRoute.transactionHistory: ""};
          _con.getTransaction();
        },
      ),
    );
  }
}
