import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();

  // Streams
  Stream<Map<int, Future<ItemModel?>>> get itemWithComments =>
      _commentsOutput.stream;

  // Sink
  // it is function which will receive int
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    // pipe means forwarding all event of one stream
    // to another
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
      (Map<int, Future<ItemModel?>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        cache[id]!.then((ItemModel? item) {
          item?.kids?.forEach((kidId) => fetchItemWithComments(kidId));
        });
        // line added by me
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  // _commentsTransformer() {
  //   /* the value comes as integer,
  //   and leaves as Map<int, Future<ItemModel>>,
  //
  //   I am using ScanStreamTransformer because it
  //   maintain some internal cache
  //   */
  //   return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
  //     //this function will be executed whenever a new data event
  //     // comes into trnasformer
  //     // it receive 3 argument, -cache: which we are passing from above
  //     // next is integer id or event: which is coming from comment fetcher stream
  //         (Map<int, Future<ItemModel?>> cache, int id, index) {
  //       // we will do recursive data fetching inside here
  //       cache[id] = _repository
  //           .fetchItem(id); // it return a future and we add it in cache map
  //       cache[id]!.then(
  //         //above then function will be called as soon as cache[id] is received, i use
  //         // then because it is future
  //         // so after it is received, below function will be executed
  //               (ItemModel? item) {
  //             item?.kids?.forEach((kidId) => fetchItemWithComments(kidId));
  //           });
  //     },
  //     // i initialize an empty map, which will serve as cache
  //     <int, Future<ItemModel?>>{},
  //   );
  // }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
