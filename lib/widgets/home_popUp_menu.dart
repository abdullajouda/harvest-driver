import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:harvest_driver/helpers/colors.dart';
import 'package:harvest_driver/helpers/constants.dart';
import 'package:harvest_driver/splash_screen.dart';
import 'package:harvest_driver/views/Drop-Menu-Views/Profile/user_profile.dart';
import 'package:harvest_driver/views/Drop-Menu-Views/Wallet/wallet.dart';
import 'package:harvest_driver/views/Drop-Menu-Views/about_us.dart';
import 'package:harvest_driver/views/Drop-Menu-Views/find_us.dart';
import 'package:harvest_driver/views/Drop-Menu-Views/privacy.dart';
import 'package:harvest_driver/views/Drop-Menu-Views/terms.dart';
import 'package:provider/provider.dart';
import 'package:harvest_driver/helpers/persistent_tab_controller_provider.dart';
import 'package:harvest_driver/helpers/Localization/app_translations.dart';

class HomePopUpMenuModel {
  final String iconPath;
  final String title;
  final VoidCallback onPressed;

  HomePopUpMenuModel({
    @required this.iconPath,
    @required this.title,
    this.onPressed,
  });
}

class HomePopUpMenu extends StatefulWidget {
  HomePopUpMenu({
    Key key,
  }) : super(key: key);

  @override
  _HomePopUpMenuState createState() => _HomePopUpMenuState();
}

class _HomePopUpMenuState extends State<HomePopUpMenu> {
  @override
  Widget build(BuildContext context) {
    final List<HomePopUpMenuModel> _options = [
      HomePopUpMenuModel(
        iconPath: Constants.homeMenuIcon,
        title: 'Home',
        onPressed: () => context.read<PTVController>().jumbToTab(AppTabs.Home),
      ),
      // HomePopUpMenuModel(
      //   iconPath: Constants.profileMenuIcon,
      //   title: 'Profile',
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       platformPageRoute(
      //         context: context,
      //         builder: (context) => UserProfile(),
      //       ),
      //     );
      //   },
      // ),
      // HomePopUpMenuModel(
      //   iconPath: 'assets/icons/credit-card.svg',
      //   title: 'wallet',
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       platformPageRoute(
      //         context: context,
      //         builder: (context) => Wallet(),
      //       ),
      //     );
      //   },
      // ),
      HomePopUpMenuModel(
        iconPath: 'assets/icons/info.svg',
        title: 'About Us',
        onPressed: () => Navigator.push(
          context,
          platformPageRoute(
            context: context,
            builder: (context) => AboutUs(),
          ),
        ),
      ),
      HomePopUpMenuModel(
        iconPath: Constants.mailMenuIcon,
        title: 'Find Us',
        onPressed: () {
          Navigator.push(
            context,
            platformPageRoute(
              context: context,
              builder: (context) => FindUS(),
            ),
          );
        },
      ),
      HomePopUpMenuModel(
        iconPath: 'assets/icons/bell.svg',
        title: 'Notifications',
      ),
      HomePopUpMenuModel(
        iconPath: Constants.termsMenuIcon,
        title: 'Terms of use',
        onPressed: () => Navigator.push(
          context,
          platformPageRoute(
            context: context,
            builder: (context) => Terms(),
          ),
        ),
      ),
      HomePopUpMenuModel(
        iconPath: Constants.privacyMenuIcon,
        title: 'Privacy',
        onPressed: () => Navigator.push(
          context,
          platformPageRoute(
            context: context,
            builder: (context) => Privacy(),
          ),
        ),
      ),
      HomePopUpMenuModel(
        iconPath: Constants.logoutMenuIcon,
        title: 'Sign out',
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.of(context, rootNavigator: true)
              .push(platformPageRoute(
            context: context,
            builder: (context) => SplashScreen(),
          ));
        },
      ),
    ];
    return PopupMenuButton<int>(
      icon: SvgPicture.asset(Constants.menuIcon, width: 15, height: 15),
      padding: EdgeInsets.zero,
      offset: Offset(-50, 10),
      onSelected: (index) {
        final _item = _options[index];
        if (_item.onPressed != null) _item.onPressed();
      },
      onCanceled: null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => List.generate(
        _options.length,
        (index) {
          final _option = _options[index];
          return PopupMenuItem(
            height: 40,
            value: index,
            enabled: _option.onPressed != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_option.iconPath != null)
                    Container(
                      height: 15,
                      width: 15,
                      child: Center(
                        child: SvgPicture.asset(_option.iconPath,
                            color: Color(0x0ff525768), width: 15, height: 15),
                      ),
                    ),
                  SizedBox(width: 6),
                  Text(
                    _option.title.trs(context),
                    style: TextStyle(
                      fontSize: 16,
                      color: CColors.headerText,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
