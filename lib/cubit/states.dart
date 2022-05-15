abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetUsersDataLoadingState extends AppStates {}
 
class AppGetUsersDataSuccessState extends AppStates {}
 
class AppGetUsersDataErrorState extends AppStates {
  String error;
  AppGetUsersDataErrorState(this.error);
}

class AppGetAllUsersLoadingState extends AppStates {}
 
class AppGetAllUsersSuccessState extends AppStates {}
 
class AppGetAllUsersErrorState extends AppStates {
  String error;
  AppGetAllUsersErrorState(this.error);
}

class AppBottomNavChangeState extends AppStates {}

class AppAddNewPostState extends AppStates {}

class ChangeProfileImageSuccessState extends AppStates {}

class ChangeProfileImageErrorState extends AppStates {}
 
class ChangeCoverImageSuccessState extends AppStates {}

class ChangeCoverImageErrorState extends AppStates {}

class ChangePostImageSuccessState extends AppStates {}

class ChangePostImageErrorState extends AppStates {}

class UpdateUserDataLoadingState extends AppStates {}

class UpdateUserDataErrorState extends AppStates {}

class UpdateProfileImageSuccessState extends AppStates {}

class UpdateProfileImageErrorState extends AppStates {}
 
class UpdateCoverImageSuccessState extends AppStates {}

class UpdateCoverImageErrorState extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {}

class RemovePostImageState extends AppStates {}

class GetPostsLoadingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {}

class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {}

class SendMessageSuccessState extends AppStates {}

class SendMessageErrorState extends AppStates {}
 
class GetMessageSuccessState extends AppStates {}

class GetMessageErrorState extends AppStates {}
 