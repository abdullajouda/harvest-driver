import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harvest_driver/components/WaveAppBar/appBar_body.dart';
import 'package:harvest_driver/helpers/api.dart';
import 'package:harvest_driver/models/order-details.dart';
import 'package:harvest_driver/models/orders.dart';
import 'package:harvest_driver/views/widgets/dialogs/confirm_dialog.dart';
import 'package:harvest_driver/views/widgets/dialogs/send_money_dialog.dart';
import 'package:harvest_driver/views/widgets/order_details_card.dart';
import 'package:harvest_driver/views/widgets/order_item.dart';
import 'package:harvest_driver/helpers/colors.dart';
import 'package:harvest_driver/helpers/constants.dart';
import 'package:harvest_driver/widgets/home_popUp_menu.dart';
import 'package:harvest_driver/widgets/my_animation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;

  const OrderDetailsPage({Key key, this.order}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  OrderDetails details;
  bool load = true;

  getDetails() async {
    setState(() {
      load = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = await get(
        ApiHelper.api + 'getDriverOrderDetail/${widget.order.id}',
        headers: {
          'Accept': 'application/json',
          'Accept-Language': 'en',
          'Authorization': 'Bearer ${prefs.getString('userToken')}'
        });
    var response = json.decode(request.body);
    var item = response['Order Details'];
    print(item);
    // Fluttertoast.showToast(msg: response['message']);
    OrderDetails orderDetails = OrderDetails.fromJson(item);
    setState(() {
      details = orderDetails;
      load = false;
    });
  }

  onConfirm(int id) {
    showCupertinoDialog(
      context: context,
      builder: (context) => Center(
          child: ConfirmDialog(
        orderId: widget.order.id,
        status: id,
      )),
    ).then((value) {
      getDetails();
    });
  }

  onAdd() {
    showCupertinoDialog(
      context: context,
      builder: (context) => Center(child: SendMoneyDialog()),
    );
  }

  LinearGradient gradient() {
    switch (widget.order.status) {
      case 1:
        return CColors.orangeAppBarGradient();
        break;
      case 2:
        return CColors.greenAppBarGradient();
        break;
      case 3:
        return CColors.blueAppBarGradient();
        break;
      case 4:
        return CColors.blackAppBarGradient();
        break;
      default:
        return CColors.greenAppBarGradient();
    }
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          load
              ? Center(
                  child:
                      Container(height: 200, width: 200, child: LoadingPhone()))
              : WaveAppBarBody(
                  backgroundGradient: gradient(),
                  bottomViewOffset: Offset(0, -10),
                  actions: [HomePopUpMenu()],
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: const Color(0xffffffff),
                      ),
                      child: Center(
                        child: SvgPicture.string(
                          '<svg viewBox="48.5 33.5 3.9 7.7" ><path transform="translate(827.02, -332.54)" d="M -774.6773681640625 366.0396728515625 L -778.5523681640625 369.9146728515625 L -774.6773681640625 373.7896118164063" fill="none" stroke="#3c4959" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        'Order Details ',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff3c4959),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: OrderDetailsCard(
                        order: widget.order,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: Text(
                        'Order Items ',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xff3c4959),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: details.orderProduct.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: OrderItem(
                          product: details.orderProduct[index],
                          color: color(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        'Add Money to Customer Wallet',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xff3c4959),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 227.0,
                          height: 33.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.0),
                            color: const Color(0x0d2c2c2c),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => onAdd(),
                          child: Container(
                            width: 65,
                            height: 33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.0),
                              color: const Color(0xfffdaa5c),
                            ),
                            child: Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xff3c4959),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 36,
                            width: 124,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: barColor(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/mobile.svg',
                                  color: color(),
                                ),
                                Text(
                                  ' Call Hala',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: color(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 36,
                            width: 124,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: barColor(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/map-pin.svg',
                                  color: color(),
                                ),
                                Text(
                                  '  Go To Map',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: color(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 118,
                    )
                  ],
                ),
          widget.order.status == 1 || widget.order.status == 2
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(21.0),
                        topRight: Radius.circular(21.0),
                      ),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x17000000),
                          offset: Offset(0, -5),
                          blurRadius: 11,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => onConfirm(4),
                          child: Container(
                            height: 40,
                            width: 147,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(color: color())),
                            child: Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                color: color(),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () =>
                              onConfirm(widget.order.status == 1 ? 2 : 3),
                          child: Container(
                            height: 40,
                            width: 147,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: color(),
                            ),
                            child: Center(
                              child: Text(
                                widget.order.status == 1
                                    ? 'Preparing'
                                    : 'Delivered',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Color color() {
    switch (widget.order.status) {
      case 1:
        return CColors.darkOrange;
        break;
      case 2:
        return CColors.darkGreen;
        break;
      case 3:
        return CColors.skyBlue;
        break;
      case 4:
        return CColors.grey;
        break;
      default:
        return CColors.darkOrange;
    }
  }

  Color barColor() {
    switch (widget.order.status) {
      case 1:
        return CColors.fadeOrange;
        break;
      case 2:
        return CColors.fadeGreen;
        break;
      case 3:
        return CColors.lightBlue;
        break;
      case 4:
        return CColors.fadeBeige;
        break;
      default:
        return CColors.fadeOrange;
    }
  }
}
