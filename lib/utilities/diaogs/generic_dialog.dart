import 'package:flutter/material.dart';

class GenericDialog {
  static bool _isDialogVisible = false;

  static void showLoadingDialog(BuildContext context, String text,
      {Color backgroundColor = Colors.white}) {
    if (!_isDialogVisible) {
      _isDialogVisible = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              // Prevent going back while the dialog is visible
              return false;
            },
            child: AlertDialog(
              backgroundColor: backgroundColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 16),
                  Text(text),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static void hideDialog(BuildContext context) {
    if (_isDialogVisible) {
      _isDialogVisible = false;
      Navigator.pop(context);
    }
  }
}
