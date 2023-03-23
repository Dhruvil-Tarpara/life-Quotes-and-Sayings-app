import 'dart:typed_data';
import 'package:flutter/material.dart';

class Quotes
{
  final String quot;
  final String author;
  late Uint8List image;

  Quotes({required this.quot, required this.author, required this.image});
  Quotes.db({required this.quot, required this.author, required this.image});

  factory Quotes.fromData({required Map data, Uint8List? image}) {
    return Quotes(quot: data["content"], author: data["author"], image: image!);
  }
}



class QuotesD
{
  final String quot;
  final String author;
  late Uint8List image;

  QuotesD({required this.quot, required this.author, required this.image});

  factory QuotesD.fromData({required Map data}) {
    return QuotesD(quot: data["content"], author: data["author"], image: data["image"]);
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  final Color color;

  DrawerItem({required this.icon, required this.title, required this.color});
}

class DrawerItem2 {
  final IconData icon;
  final String title;

  DrawerItem2({required this.icon, required this.title});
}
