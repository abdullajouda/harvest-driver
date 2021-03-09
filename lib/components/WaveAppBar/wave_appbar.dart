import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harvest_driver/helpers/constants.dart';


export 'appBar_body.dart';
export 'pinned_header.dart';

const double kWaveAppBarHeight = 100.0;
const double kWaveAppBarDelegateMaxHeight = 125.0;
const double kWaveAppBarDelegateMinHeight = 80.0;
const double kWaveAppBarDelegateCollapsedHeight = 20.0;
const double kWaveAppBarRadius = 40.0;
const double kShadowElevation = 8.0;

double _degreeToRadian(double degree) => degree * (pi / 180);

class _DefaultWaveAppBarTag {
  const _DefaultWaveAppBarTag();
  @override
  String toString() => '<default WaveAppBar tag>';
}

class WaveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final Offset bottomViewOffset;
  final Widget bottomView;
  final List<Widget> actions;
  final bool hideActions;
  final Gradient backgroundGradient;
  final Object heroTag;
  final double height;
  final double raduis;
  final double elevation;
  final Color shadowColor;
  final Brightness brightness;

  const WaveAppBar({
    Key key,
    this.leading,
    this.bottomViewOffset = const Offset(0, -8),
    this.bottomView,
    this.actions,
    this.hideActions = false,
    this.backgroundGradient,
    this.heroTag = const _DefaultWaveAppBarTag(),
    this.height = kWaveAppBarHeight,
    this.raduis = kWaveAppBarRadius,
    this.elevation = 0.0,
    this.shadowColor,
    this.brightness = Brightness.light,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: brightness != Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Material(
        elevation: elevation,
        shadowColor: shadowColor,
        child: Stack(
          clipBehavior: Clip.none, children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(
                raduis: raduis,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: backgroundGradient,
                    ),
                  ),
                  Positioned(
                    top: -(size.height * 0.2),
                    left: -(size.width * 0.45),
                    child: Transform.rotate(
                      angle: _degreeToRadian(8),
                      child: SvgPicture.asset(Constants.appBarGradient),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // leading ?? CBackButton(),
                          // if (!hideActions) Row(mainAxisSize: MainAxisSize.min, children: actions ?? [HomePopUpMenu()]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (bottomView != null)
              Positioned(
                left: 0,
                right: bottomViewOffset?.dx ?? 0,
                top: 70.0 - (bottomViewOffset?.dy ?? 0.0),
                child: Center(child: bottomView),
              ),
            Positioned(
                left: 10,
                top: 40,
                child: leading),
            Positioned(
                right: 0,
                top: 30,
                child: actions[0]??Container()),
          ],
        ),
      ),
    );
  }
}

class OvalBottomBorderClipper extends CustomClipper<Path> {
  final double raduis;

  const OvalBottomBorderClipper({
    this.raduis,
  });
  @override
  Path getClip(Size size) {
    const double ratio = 20 / 50;
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - raduis);
    path.quadraticBezierTo(
      size.width / 4,
      size.height - raduis * ratio,
      size.width / 2,
      size.height - raduis * ratio,
    );
    path.quadraticBezierTo(
      size.width - size.width / 4,
      size.height - raduis * ratio,
      size.width,
      size.height - raduis,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
