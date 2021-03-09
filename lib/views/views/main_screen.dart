import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harvest_driver/components/WaveAppBar/appBar_body.dart';
import 'package:harvest_driver/helpers/api.dart';
import 'package:harvest_driver/models/orders.dart';
import 'package:harvest_driver/views/views/order_details.dart';
import 'package:harvest_driver/helpers/colors.dart';
import 'package:harvest_driver/helpers/constants.dart';
import 'package:harvest_driver/helpers/custom_page_transition.dart';
import 'package:harvest_driver/widgets/home_popUp_menu.dart';
import 'package:harvest_driver/views/widgets/order_card.dart';
import 'package:harvest_driver/widgets/my_animation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Order> _orders = [];
  bool loadOffers = true;

  getOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = await get(ApiHelper.api + 'getDriverOrders/-1', headers: {
      'Accept': 'application/json',
      'Accept-Language': 'en',
      'Authorization': 'Bearer ${prefs.getString('userToken')}'
    });
    var response = json.decode(request.body);
    var items = response['items'];
    // Fluttertoast.showToast(msg: response['message']);
    items.forEach((element) {
      Order x = Order.fromJson(element);
      _orders.add(x);
    });
    setState(() {
      loadOffers = false;
    });
  }

  @override
  void initState() {
    getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaveAppBarBody(
        backgroundGradient: CColors.greenAppBarGradient(),
        bottomViewOffset: Offset(0, -10),
        // topHeader: PinnedTopHeader(
        //   maxHeight: 45,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 10),
        //     child: CategorySelector(
        //       categories: [Category()],
        //     ),
        //   ),
        // ),
        actions: [HomePopUpMenu()],
        leading: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   platformPageRoute(
              //     context: context,
              //     builder: (context) => Basket(),
              //   ),
              // );
            },
            child: SvgPicture.asset(Constants.basketIcon)),
        child: loadOffers
            ? Center(
                child:
                    Container(height: 200, width: 200, child: LoadingPhone()))
            : ListView.builder(
                itemCount: _orders.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        CustomPageRoute(
                          builder: (context) => OrderDetailsPage(
                            order: _orders[index],
                          ),
                        )),
                    child: OrderCard(
                      order: _orders[index],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
