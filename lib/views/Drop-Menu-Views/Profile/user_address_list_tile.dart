import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harvest_driver/helpers/Localization/localization.dart';
import 'package:harvest_driver/helpers/colors.dart';
import 'package:harvest_driver/helpers/constants.dart';
import 'package:harvest_driver/widgets/remove_icon.dart';

class UserAddressListTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final int index;

  const UserAddressListTile({
    Key key,
    this.isSelected,
    this.onTap,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTranslations trs = AppTranslations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none, children: [
          RemoveIcon(
            enabled: isSelected,
            child: Container(
              child: Row(
                children: [
                  Radio<int>(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: index,
                    groupValue: isSelected ? index : -1,
                    onChanged: (_) {},
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? CColors.fadeBlue : CColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color:
                                !isSelected ? CColors.fadeBlue : CColors.white,
                            width: 2),
                      ),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        leading: SvgPicture.asset(Constants.mapPinIcon),
                        title: Text("delivery_address".trs(context)),
                        subtitle: Text("AlQahera, Jamal 43st, CD 43, 4 floor"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.directional(
            textDirection: trs.textDirection,
            end: -10,
            top: -10,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CColors.darkOrange,
                border: Border.all(color: CColors.white, width: 3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
