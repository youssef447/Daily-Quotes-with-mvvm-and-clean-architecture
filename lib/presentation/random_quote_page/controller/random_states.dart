abstract class RandomStates {}

class RandomInitialState extends RandomStates {}

class GetRandomLoadingState extends RandomStates {}

class GetRandomSuccessState extends RandomStates {}

class GetRandomErrorState extends RandomStates {
  final String err;
  GetRandomErrorState(
    this.err,
  );
}

class AddToPopularLoadingState extends RandomStates {}

class AddToPopularSuccessState extends RandomStates {}

class AddToPopularErrorState extends RandomStates {
  final String err;
  AddToPopularErrorState(
    this.err,
  );
}


class RemoveFromPopularLoadingState extends RandomStates {}

class RemoveFromPopularSuccessState extends RandomStates {}

class RemoveFromPopularErrorState extends RandomStates {
  final String err;
  RemoveFromPopularErrorState(
    this.err,
  );
}
class SharingQuoteErrorState extends RandomStates {
  final String err;
  SharingQuoteErrorState(
    this.err,
  );
}