abstract class MyQuotesPageStates {}

class MyQuotesPageInitialState extends MyQuotesPageStates {}

class GetMyQuotesPageLoadingState extends MyQuotesPageStates {}

class GetMyQuotesPageSuccessState extends MyQuotesPageStates {}

class GetMyQuotesPageErrorState extends MyQuotesPageStates {
  final String err;
  GetMyQuotesPageErrorState(this.err);
}

class RemoveMyQuoteLoadingState extends MyQuotesPageStates {}

class RemoveMyQuoteSuccessState extends MyQuotesPageStates {}

class RemoveMyQuoteErrorState extends MyQuotesPageStates {
  final String err;
  RemoveMyQuoteErrorState(this.err);
}

class SharingQuoteErrorState extends MyQuotesPageStates {
  final String err;
  SharingQuoteErrorState(
    this.err,
  );
}
