import 'package:flutter/material.dart';
import 'memo.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.model, this.changeMemo})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final model;

  // ignore: prefer_typing_uninitialized_variables
  final changeMemo;

  @override
  Widget build(BuildContext context) {
    final isUpdate = changeMemo != null;
    String title = '';
    String text = '';
    final titleEditingController = TextEditingController();
    final detailEditingController = TextEditingController();
    if (isUpdate) {
      titleEditingController.text = changeMemo.value.title;
      detailEditingController.text = changeMemo.value.text;
      title = changeMemo.value.title;
      text = changeMemo.value.text;
    }
    Memo memo = Memo();
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'update' : 'create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'title',
                  hintText: 'title',
                ),
                onChanged: (t) {
                  title = t;
                },
                controller: titleEditingController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'text',
                  hintText: 'text',
                ),
                onChanged: (t) {
                  text = t;
                },
                controller: detailEditingController,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "add",
            onPressed: () async {
              memo.title = title;
              memo.text = text;
              isUpdate
                  ? await model.update(changeMemo.key, memo)
                  : await model.add(memo);
              Navigator.pop(context);
            },
            child: const Icon(Icons.add),
          ),
          if (isUpdate) const SizedBox(width: 10),
          if (isUpdate)
            FloatingActionButton(
                heroTag: "delete",
                onPressed: () async {
                  await showDialog<int>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Alert'),
                        content: const Text(
                            'Are you sure you want to delete this memo?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              model.delete(changeMemo.key);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
