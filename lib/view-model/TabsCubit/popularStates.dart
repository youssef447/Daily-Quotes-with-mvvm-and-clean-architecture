abstract class PopularStates {}

class PopularInitialState extends PopularStates {}

class GetPopularLoadingState extends PopularStates {}

class GetPopularSucessState extends PopularStates {}

class GetPopularErrorState extends PopularStates {
  final String err;
  GetPopularErrorState(this.err);
}
class RemoveFromPopularLoadingState extends PopularStates {}

class RemoveFromPopularSuccessState extends PopularStates {}

class RemoveFromPopularErrorState extends PopularStates {
  final String err;
  RemoveFromPopularErrorState(
    this.err,
  );
}