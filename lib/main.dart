import 'package:flutter/cupertino.dart';
import 'package:hacker_news/src/app.dart';
import 'package:hacker_news/src/resources/news_db_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  newsDbProvider.init();
  runApp(App());
}
