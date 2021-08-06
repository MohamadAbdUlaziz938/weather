import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildBusyIndicator() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Platform.isAndroid ?CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)):CupertinoActivityIndicator(),
    SizedBox(
      height: 20,
    ),
    Text('Please Wait...',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ))
  ]);
}