
abstract class SocialAppLoginStates {}

class SocialAppLoginInitialState extends SocialAppLoginStates {}

class SocialAppLoginLoadingState extends SocialAppLoginStates {}

class SocialAppLoginSuccessState extends SocialAppLoginStates {
String? uid; 
SocialAppLoginSuccessState(this.uid);
}

class SocialAppLoginErrorState extends SocialAppLoginStates {
  final String error;

  SocialAppLoginErrorState(this.error);
}

class SocialAppLoginnVisibleState extends SocialAppLoginStates {}

