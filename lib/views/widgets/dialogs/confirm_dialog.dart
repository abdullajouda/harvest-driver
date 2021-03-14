import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harvest_driver/helpers/api.dart';
import 'package:harvest_driver/helpers/colors.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmDialog extends StatefulWidget {
  final int orderId;
  final int status;

  const ConfirmDialog({Key key, this.orderId, this.status}) : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  bool load = false;

  changeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      load = true;
    });
    var request =
        await post(ApiHelper.api + 'changeOrderStatusByDriver', body: {
      'order_id': '${widget.orderId}',
      'status': '${widget.status}'
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('userToken')}',
      'Accept-Language': prefs.getString('language'),
    });
    var response = json.decode(request.body);
    Fluttertoast.showToast(msg: response['message']);
    if (response['status'] == true) {
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 154,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 146,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.elliptical(9999.0, 9999.0)),
                          color: const Color(0xa3f88518),
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                                'assets/icons/alert-triangle.svg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Are You Sure ?',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontSize: 14,
                            color: const Color(0xff3c4959),
                            letterSpacing: 0.14,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 35,
                              width: 84,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(color: CColors.darkOrange),
                              ),
                              child: Center(
                                  child: Text(
                                'No',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Rounded',
                                  fontSize: 16,
                                  color: CColors.darkOrange,
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
                            onTap: () => changeStatus(),
                            child: Container(
                              height: 35,
                              width: 84,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: CColors.darkOrange,
                              ),
                              child: Center(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Rounded',
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
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: Colors.white60,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x12000000),
                          offset: Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/icons/cancel.svg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
