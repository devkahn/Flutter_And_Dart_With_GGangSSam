
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDialogHelper{
  static void MakeDialog(BuildContext context, String msg){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(msg),);
        }
    );
  }
}