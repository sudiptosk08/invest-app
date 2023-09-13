import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/screen/recharge/state/pagination_scroll_state.dart';
import 'package:invest_app/view/screen/withdraw/controller/withdraw_history_controller.dart';


final withdrawHistoryScrollProvider =
    StateNotifierProvider<RechargeHistoryScrollController, ScrollState>(
        (ref) => RechargeHistoryScrollController(ref: ref));

class RechargeHistoryScrollController extends StateNotifier<ScrollState> {
  final Ref? ref;

  RechargeHistoryScrollController({this.ref})
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
      ref!.read(withdrawHistoryProvider.notifier).fetchMoreWithdrawHistory();
      state = const ScrollReachedBottomState();
    }
  }

  resetState() {
    state = const ScrollInitialState();
  }
}
