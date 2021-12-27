import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'memo.dart';

class MemoList extends ChangeNotifier {
  MemoList() {
    get();
  }

  List<MapEntry<String, Memo>> memos = [];

  //全要素の取得
  void get() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    memos = [];

    //memosにデータを格納
    for (String key in keys) {
      if (key != 'lastKey') {
        String? rowValue = prefs.getString(key);
        Map<String, dynamic> jsonValue = json.decode(rowValue!);
        Memo memo = Memo.fromJson(jsonValue);
        memos.add(MapEntry(key, memo));
      }
    }

    //変更の通知
    notifyListeners();
  }

  //要素の追加
  void add(Memo memo) async {
    final prefs = await SharedPreferences.getInstance();
    int? assignKey = prefs.getInt('lastKey');

    if (assignKey == null) {
      //初回書き込み
      prefs.setString('0', json.encode(memo));
      prefs.setInt('lastKey', 0);
    } else {
      //2回目以降の書き込み
      assignKey += 1;

      prefs.setString(assignKey.toString(), json.encode(memo));
      prefs.setInt('lastKey', assignKey);
    }
    //全要素を更新
    get();
  }

  //要素の更新
  void update(String key, Memo memo) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(memo));

    //全要素を更新
    get();
  }

  //要素の削除
  void delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);

    //全要素を更新
    get();
  }
}
