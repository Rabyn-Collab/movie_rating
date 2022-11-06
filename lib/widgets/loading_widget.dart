import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';


class CustomLoadingSpinKitRing extends StatelessWidget {


@override
Widget build(BuildContext context) {
  return Stack(
    children: [
      Center(
        child: Icon(
          Icons.videocam,
          size: 20.0.sp,
          color:  Colors.blueGrey,
        ),
      ),
      SpinKitRing(
        color:  Colors.white,
        size: 50.0.sp,
        lineWidth: 2.0.sp,
      ),
    ],
  );
}
}