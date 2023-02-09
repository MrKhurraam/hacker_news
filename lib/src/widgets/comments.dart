import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/src/widgets/loading_container.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel?>>? itemMap;
  final int? depth;

  Comment({Key? key, required this.itemId, this.itemMap, this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap?[itemId],
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: Text(
              item?.text == '' ? "Deleted" : "${buildText(item?.text)}",
              textAlign: TextAlign.justify,
            ),
            subtitle:
                item?.by == "" ? Text("Deleted") : Text("auther: ${item?.by}"),
            contentPadding: EdgeInsets.only(left: depth! * 16, right: 16),
          ),
          Divider(),
        ];

        snapshot.data?.kids?.forEach(
          (kidId) {
            children.add(
              Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth! + 1,
              ),
            );
          },
        );

        return Column(
          children: children,
        );
      },
    );
  }

  String? buildText(String? text) {
    final text1 = text
        ?.replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');

    return text1;
  }
}
