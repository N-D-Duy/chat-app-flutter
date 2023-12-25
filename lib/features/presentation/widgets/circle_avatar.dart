import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCirlceAvatar extends StatelessWidget {
  final String name;
  final String image;
  final bool isSpecialBorder;

  const MyCirlceAvatar(
      {super.key,
      required this.name,
      required this.image,
      required this.isSpecialBorder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          isSpecialBorder
              ? SvgPicture.asset(
                  'assets/images/profile_border_1.svg',
                  width: 26,
                  height: 26,
                )
              : SvgPicture.asset(
                  'assets/images/profile_border_2.svg',
                  width: 26,
                  height: 26,
                ),
          Positioned(
            top: 2,
            left: 2,
            right: 2,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(image),
            ),
          ),
          Container(
            height: 8,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    ); 
  }
}
