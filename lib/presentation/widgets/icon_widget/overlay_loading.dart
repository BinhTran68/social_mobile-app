import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OverlayLoading extends StatelessWidget {
  const OverlayLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5), // Màn phủ mờ
      child:  Center(
        child: LoadingAnimationWidget.flickr(
            leftDotColor: Colors.red,
            rightDotColor: Colors.blue, size:50), // Nút xoay loading
      ),
    );
  }
}
