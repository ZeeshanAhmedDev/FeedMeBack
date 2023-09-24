import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassMorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;

  const GlassMorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(opacity),
            borderRadius: BorderRadius.all(Radius.circular(35.r)),
            border: Border.all(
              width: 2.w,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
