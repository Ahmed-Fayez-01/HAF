abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class ChangeSuffixIconState extends RegisterStates {}
class OnStepCancelState extends RegisterStates {}
class OnStepTapState extends RegisterStates {}
class OnStepContinueState extends RegisterStates {}
class PickedImageSuccessState extends RegisterStates{}
class selectedIndexesUpdatState extends RegisterStates{}

class ToastState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
}

class RegisterErrorState extends RegisterStates {
  final error;

  RegisterErrorState(this.error);
}
