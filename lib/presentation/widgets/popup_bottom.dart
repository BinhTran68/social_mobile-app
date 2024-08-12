import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> popupBottom(
    {required BuildContext context, required Widget child}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return child;
    },
  );
}
