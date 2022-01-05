import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        period: Duration(
          milliseconds: 500,
        ),
        baseColor: Colors.blue[100]!,
        highlightColor: Colors.blue[300]!,
        child: Container(
          height: height,
          width: width,
          decoration: ShapeDecoration(
            shape: shapeBorder,
            color: Colors.blue[100]!,
          ),
        ),
      ),
    );
  }
}
