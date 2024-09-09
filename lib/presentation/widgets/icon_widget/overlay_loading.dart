import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayLoading extends StatelessWidget {
  const OverlayLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5), // Màn phủ mờ
      child: const Center(
        child: CircularProgressIndicator(), // Nút xoay loading
      ),
    );
  }
}
