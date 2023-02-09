import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final bloc = StoriesBloc();

  StoriesProvider({required Widget child}) : super(child: child);

  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StoriesProvider>()!
        .bloc; //here
  }
}
