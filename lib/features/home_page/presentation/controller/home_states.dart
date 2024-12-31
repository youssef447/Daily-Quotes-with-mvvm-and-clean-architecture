abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetShapeLoadingState extends HomeStates {}

class GetShapeSuccessState extends HomeStates {}

class GetShapeErrorState extends HomeStates {
  final String err;
  GetShapeErrorState(this.err);
}

class ChangeShapeState extends HomeStates {}

class ChangeNotificationSuccessState extends HomeStates {}

class ChangeNotificationLoadingState extends HomeStates {}

class ChangeNotificationErrorState extends HomeStates {
  final String err;
  ChangeNotificationErrorState(this.err);
}

class ChangeTabState extends HomeStates {}
