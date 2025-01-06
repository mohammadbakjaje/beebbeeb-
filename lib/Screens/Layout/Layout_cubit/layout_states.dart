abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class GetUserDataLoadingState extends LayoutStates {}

class FailedToGetUserDataState extends LayoutStates {
  String? errMsg;
  FailedToGetUserDataState({required this.errMsg});
}

class GetUserDataSuccsesState extends LayoutStates {}
