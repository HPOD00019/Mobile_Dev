import 'package:flutter/material.dart';

typedef PopupAction = VoidCallback;

void showTwoOptionPopup(
  BuildContext context, {
  required String title,
  required String message,
  required String firstOptionLabel,
  required PopupAction onFirstOption,
  required String secondOptionLabel,
  required PopupAction onSecondOption,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onFirstOption();
          },
          child: Text(firstOptionLabel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onSecondOption();
          },
          child: Text(secondOptionLabel),
        ),
      ],
    ),
  );
}
