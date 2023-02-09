import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/comments_provider.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/screens/news_details.dart';
import 'package:hacker_news/src/screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "Hacker News",
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == "/") {
              return MaterialPageRoute(
                builder: (context) {
                  final bloc = StoriesProvider.of(context);
                  bloc.fetchTopIds();

                  return NewsList();
                },
              );
            } else {
              return MaterialPageRoute(
                builder: (context) {
                  final itemId =
                  int.parse(settings.name!.replaceFirst('/', ''));
                  final commentsBloc = CommentsProvider.of(context);
                  commentsBloc.fetchItemWithComments(itemId);

                  return NewsDetail(itemId: itemId);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
