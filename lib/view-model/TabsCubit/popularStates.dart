abstract class PopularStates {}

class PopularInitialState extends PopularStates {}

class GetPopularLoadingState extends PopularStates {}

class GetPopularSucessState extends PopularStates {}

class GetPopularErrorState extends PopularStates {
  final String err;
  GetPopularErrorState(this.err);
}
