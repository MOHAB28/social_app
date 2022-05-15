

abstract class SocialAppRegisterStates {}

class SocialAppRegisterInitialState extends SocialAppRegisterStates {}

class SocialAppRegisterLoadingState extends SocialAppRegisterStates {}

class SocialAppRegisterSuccessState extends SocialAppRegisterStates {

}

class SocialAppRegisterErrorState extends SocialAppRegisterStates {
  final String error;

  SocialAppRegisterErrorState(this.error);
}

class SocialAppRegisterVisibleState extends SocialAppRegisterStates {}

class SocialAppCreateUserLoadingState extends SocialAppRegisterStates {}

class SocialAppCreateUserSuccessState extends SocialAppRegisterStates {
 String uid;
 SocialAppCreateUserSuccessState(this.uid);
}

class SocialAppCreateUserErrorState extends SocialAppRegisterStates {
  final String error;

  SocialAppCreateUserErrorState(this.error);
}
