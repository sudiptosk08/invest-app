import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/screen/profile/controller/get_earning_history_controller.dart';
import 'package:invest_app/view/screen/recharge/state/pagination_scroll_state.dart';


final earningHistoryScrollProvider =
    StateNotifierProvider<EarningHistoryScrollController, ScrollState>(
        (ref) => EarningHistoryScrollController(ref: ref));

class EarningHistoryScrollController extends StateNotifier<ScrollState> {
  final Ref? ref;

  EarningHistoryScrollController({this.ref})
      : super(const ScrollInitialState());

  ScrollController _scrollController = ScrollController();

  get controller {
    _scrollController.addListener(scrollListener);
    return _scrollController;
  }

  set setController(ScrollController scrollController) {
    _scrollController = scrollController;
  }

  get scrollNotifierState => state;

  scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref!.read(earningHistoryProvider.notifier).fetchMoreEarningHistory();
      state = const ScrollReachedBottomState();
    }
  }

  resetState() {
    state = const ScrollInitialState();
  }
}
