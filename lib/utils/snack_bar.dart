import 'package:flutter/material.dart';
import 'package:get/get.dart';

final kPadding = 8.0; // up to you

class Snack {
  /// show the snack bar
  /// [content] is responsible for the text of the snack bar
  static show({
   // required String title,
    required String content,
    required BuildContext context,
    SnackType snackType = SnackType.info,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.all(10),
       // duration: Duration.mic,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getSnackbarTitle(snackType),
              style: context.textTheme.headline6
                  ?.copyWith(color: _getSnackbarTextColor(snackType)),
            ),
            SizedBox(height: 20,),
            Text(
              content,
              style: context.textTheme.subtitle1
                  ?.copyWith(color: _getSnackbarTextColor(snackType)),
            ),
          ],
        ),
        behavior: behavior,
        backgroundColor: _getSnackbarColor(snackType),
        padding:EdgeInsets.symmetric(
          horizontal: kPadding * 3,
          vertical: kPadding * 2,
        ),
      ),
    );
  }

  static Color _getSnackbarColor(SnackType type) {
    if (type == SnackType.error) return const Color(0xffFF7A7A);
    if (type == SnackType.warning) return Colors.amber;
    if (type == SnackType.info) return Colors.green;
    return Colors.white;
  }

  static String _getSnackbarTitle(SnackType type) {
    if (type == SnackType.error) return "Error";
    if (type == SnackType.warning) return "Warning";
    if (type == SnackType.info) return "Success";
    return "Undefined";
  }

  static Color _getSnackbarTextColor(SnackType type) {
    if (type == SnackType.error || type == SnackType.info) return Colors.white;

    return const Color(0xff1C1C1C);
  }
}

enum SnackType { info, warning, error }