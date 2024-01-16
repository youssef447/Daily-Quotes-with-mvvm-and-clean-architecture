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
