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

class RemoveFromPopularLoadingState extends TodayStates {}

class RemoveFromPopularSuccessState extends TodayStates {}

class RemoveFromPopularErrorState extends TodayStates {
  final String err;
  RemoveFromPopularErrorState(
    this.err,
  );
}


class SharingQuoteErrorState extends TodayStates {
  final String err;
  SharingQuoteErrorState(
    this.err,
  );
}

