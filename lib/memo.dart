import 'package:flutter/material.dart';

class Memo extends ChangeNotifier {
  String title = '';
  String text = '';

  Memo();

  Memo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'text': text,
      };
}
