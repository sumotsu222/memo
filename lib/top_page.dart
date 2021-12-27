import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'memo_list.dart';
import 'detail_page.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemoList>(
      create: (_) => MemoList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Memo'),
          leading: const FlutterLogo(),
        ),
        body: Consumer<MemoList>(builder: (context, model, child) {
          final memoList = model.memos;
          return ListView(
            children: memoList
                .map(
                  (memo) => Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: memo.value.title,
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailPage(model: model, changeMemo: memo);
                        }));
                      },
                    ),
                  ),
                )
                .toList(),
          );
        }),
        floatingActionButton:
            Consumer<MemoList>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailPage(model: model);
              }));
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
