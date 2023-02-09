import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/src/widgets/comments.dart';

import '../blocs/comments_provider.dart';
import '../models/item_model.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }

        final itemFuture = snapshot.data![itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("Loading 2 ");
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel? item, Map<int, Future<ItemModel?>>? itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));

    final commentsList = item?.kids?.map((kidId) {
      return Comment(
        itemId: itemId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();

    children.addAll(commentsList!);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel? item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(8),
      child: Text(
        textAlign: TextAlign.center,
        "${item?.title}",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
