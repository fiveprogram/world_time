import 'package:flutter/material.dart';

import '../../res/constants.dart';

class ClockContainer extends StatelessWidget {
  final Widget child;

  const ClockContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: 270,
            height: 270,
            decoration: const BoxDecoration(
              color: AppColors.darkClockBg,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: child,
        ),
        Center(
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
