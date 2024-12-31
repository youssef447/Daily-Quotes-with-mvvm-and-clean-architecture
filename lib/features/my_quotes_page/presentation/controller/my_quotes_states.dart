abstract class MyQuotesStates {}

class MyQuotesInitialState extends MyQuotesStates {}

class GetMyQuotesLoadingState extends MyQuotesStates {}

class GetMyQuotesSuccessState extends MyQuotesStates {}

class GetMyQuotesErrorState extends MyQuotesStates {
  final String err;
  GetMyQuotesErrorState(this.err);
}



class RemoveMyQuoteLoadingState extends MyQuotesStates {}

class RemoveMyQuoteSuccessState extends MyQuotesStates {}

class RemoveMyQuoteErrorState extends MyQuotesStates {
  final String err;
  RemoveMyQuoteErrorState(this.err);
}
class SharingQuoteErrorState extends MyQuotesStates {
  final String err;
  SharingQuoteErrorState(
    this.err,
  );
}