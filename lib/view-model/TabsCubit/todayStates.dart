abstract class TodayStates {}

class TodayInitialState extends TodayStates {}

class GetTodayQuoteLoadingState extends TodayStates {}

class GetTodayQuoteSuccessState extends TodayStates {}

class GetTodayQuoteErrorState extends TodayStates {
  final String err;
  GetTodayQuoteErrorState(this.err);
}


class AddToPopularLoadingState extends TodayStates {}

class AddToPopularSuccessState extends TodayStates {}

class AddToPopularErrorState extends TodayStates {
  final String err;
  AddToPopularErrorState(
    this.err,
  );
}
