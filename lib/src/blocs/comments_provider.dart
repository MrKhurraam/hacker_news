import 'package:flutter/cupertino.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {

  final bloc = CommentsBloc();

  CommentsProvider({required Widget child}) : super(child: child);

  bool updateShouldNotify(_) => true;

  static CommentsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CommentsProvider>()!
        .bloc; //here
  }
}