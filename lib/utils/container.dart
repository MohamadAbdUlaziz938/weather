import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container container(context, {Color colorbackground, Color colortext=Colors.white, String feature,
    String details,double fontSize=18,double padding=0,double marginLeft=0,double marginRight=0,Color textColor=Colors.black}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(padding),
    margin: EdgeInsets.only(left: marginLeft,right: marginRight),
    //solving the problem of increasing text in row
    child:
    // RichText(
    //   text: TextSpan(
    //       style: TextStyle(fontSize: fontSize, color: Colors.white),
    //       children: <TextSpan>[
    //         TextSpan(text: feature),
    //         TextSpan(text: details??"", style: TextStyle(color: colortext)),
    //       ]),),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text( feature,style: TextStyle(fontWeight: FontWeight.w500,fontSize: fontSize,color: textColor),),
        Text(""),
        Text(details??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: fontSize)),
      ],
    ),

  );
}