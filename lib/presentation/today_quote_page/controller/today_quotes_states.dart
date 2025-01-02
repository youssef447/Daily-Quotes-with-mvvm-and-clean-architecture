abstract class TodayQuoteStates {}

class TodayInitialState extends TodayQuoteStates {}

class GetTodayQuoteLoadingState extends TodayQuoteStates {}

class GetTodayQuoteSuccessState extends TodayQuoteStates {}

class GetTodayQuoteErrorState extends TodayQuoteStates {
  final String err;
  GetTodayQuoteErrorState(this.err);
}

class AddToPopularLoadingState extends TodayQuoteStates {}

class AddToPopularSuccessState extends TodayQuoteStates {}

class AddToPopularErrorState extends TodayQuoteStates {
  final String err;
  AddToPopularErrorState(
    this.err,
  );
}

class RemoveFromPopularLoadingState extends TodayQuoteStates {}

class RemoveFromPopularSuccessState extends TodayQuoteStates {}

class RemoveFromPopularErrorState extends TodayQuoteStates {
  final String err;
  RemoveFromPopularErrorState(
    this.err,
  );
}

class SharingQuoteErrorState extends TodayQuoteStates {
  final String err;
  SharingQuoteErrorState(
    this.err,
  );
}
