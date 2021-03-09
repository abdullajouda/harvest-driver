import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harvest_driver/components/WaveAppBar/wave_appbar.dart';

import 'package:harvest_driver/helpers/constants.dart';
import 'package:harvest_driver/widgets/custom_main_button.dart';
import 'wallet_amount_viewer.dart';
import 'package:harvest_driver/helpers/Localization/localization.dart';
import 'package:harvest_driver/helpers/colors.dart';
import 'package:harvest_driver/widgets/home_popUp_menu.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: WaveAppBar(
        // hideActions: true,
        backgroundGradient: CColors.greenAppBarGradient(),
        bottomViewOffset: Offset(0, -10),
        actions: [HomePopUpMenu()],
        leading: SvgPicture.asset(Constants.basketIcon),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            Text(
              "wallet".trs(context),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: CColors.headerText,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            WalletAmount(amount: 250.055, margin: EdgeInsets.zero),
            SizedBox(height: 20),
            _buildConvertPointsToWallet(context),
            SizedBox(height: size.height * 0.06),
            _WalletChargingSelector(),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: const Color(0x0d2c2c2c),
                      ),
                      child: Center(
                        child: Container(
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: const Color(0xff3c984f),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        "add_from_your_card".trs(context),
                        style: TextStyle(
                          color: CColors.lightGreen,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                    border: Border.all(width: 2.0, color: const Color(0xffffeede)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x14535353),
                        offset: Offset(0, 5),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/credit-card.svg',
                          color: CColors.darkOrange,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "card".trs(context),
                          style: TextStyle(
                            color: CColors.darkOrange,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MainButton(
                title: 'Submit',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildConvertPointsToWallet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CColors.fadeOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: "7,000",
                style: TextStyle(
                  color: CColors.darkOrange,
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                ),
                children: [
                  TextSpan(
                    text: "\t" + "points".trs(context),
                    style: TextStyle(
                      color: CColors.darkOrange,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            FlatButton.icon(
              color: CColors.darkOrange,
              // padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
              icon: SvgPicture.asset(Constants.moneyExchange, width: 14),
              label: Text(
                "convert_to_wallet".trs(context),
                style: TextStyle(
                  color: CColors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletChargingSelector extends StatefulWidget {
  const _WalletChargingSelector({
    Key key,
  }) : super(key: key);

  @override
  __WalletChargingSelectorState createState() =>
      __WalletChargingSelectorState();
}

class __WalletChargingSelectorState extends State<_WalletChargingSelector> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "charge_wallet_from_card".trs(context),
          style: TextStyle(
            color: CColors.lightGreen,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "select_the_amount".trs(context),
                style: TextStyle(
                  color: CColors.normalText,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: size.height * 0.09,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final _isSelected = _selectedIndex == index;
                          final _textColor =
                              _isSelected ? CColors.white : CColors.lightGreen;
                          final _backgroundColor =
                              !_isSelected ? CColors.white : CColors.lightGreen;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedIndex = index);
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: _backgroundColor,
                                border: Border.all(
                                    color: CColors.lightGreen, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${50 * (index + 1)}",
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Rounded',
                                      fontSize: 16,
                                      color: _textColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "usd".trs(context),
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: _textColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "another_amount".trs(context),
                              style: TextStyle(
                                fontSize: 11,
                                color: CColors.lightGreen,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextField(
                              style: TextStyle(fontSize: 12),
                              onTap: () {
                                setState(() => _selectedIndex = -1);
                              },
                              decoration: InputDecoration(
                                prefix: Text(
                                  '\$',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Rounded',
                                    fontSize: 8,
                                    color: const Color(0x993c984f),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 10, top: 9, bottom: 9),
                                hintStyle: TextStyle(fontSize: 12),
                                border: _buildVoucherTextFieldBorder(),
                                focusedBorder: _buildVoucherTextFieldBorder(),
                                enabledBorder: _buildVoucherTextFieldBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ShapeBorder _buildVoucherTextFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Color(0x0ff3C984F), width: 1),
    );
  }
}
