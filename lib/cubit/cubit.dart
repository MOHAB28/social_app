import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constance/components.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat/chat.dart';
import 'package:social_app/modules/home/home_screen.dart';
import 'package:social_app/modules/post/post_screen.dart';
import 'package:social_app/modules/settings/settings.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userData;
  void getUserData() {
    emit(AppGetUsersDataLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userData = UserModel.fromJson(value.data());
      emit(AppGetUsersDataSuccessState());
    }).catchError((error) {
      emit(AppGetUsersDataErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    AddNewPost(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> title = [
    'Home',
    'Chats',
    '',
    'Users',
    'Settings',
  ];

  void changeCurrentIndex(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(AppAddNewPostState());
    } else {
      currentIndex = index;
      emit(AppBottomNavChangeState());
    }
  }

  var picker = ImagePicker();
  File? profileImage;

  Future<void> getProfileImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(ChangeProfileImageSuccessState());
    } else {
      emit(ChangeProfileImageErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(ChangeCoverImageSuccessState());
    } else {
      emit(ChangeCoverImageErrorState());
    }
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    emit(UpdateUserDataLoadingState());
    UserModel model = UserModel(
      bio: bio,
      cover: cover ?? userData!.cover,
      email: userData!.email,
      image: image ?? userData!.image,
      name: name,
      phone: phone,
      uid: userData!.uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  void updateProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file('${userData!.image}').pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) => {
                updateUser(
                  name: name,
                  bio: bio,
                  phone: phone,
                  image: value,
                )
              })
          .catchError((error) {
        emit(UpdateProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UpdateProfileImageErrorState());
    });
  }

  void updateCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file('${userData!.cover}').pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) => {
                updateUser(
                  name: name,
                  bio: bio,
                  phone: phone,
                  cover: value,
                )
              })
          .catchError((error) {
        emit(UpdateCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UpdateCoverImageErrorState());
    });
  }

  File? postImage;

  Future<void> getpostImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(ChangePostImageSuccessState());
    } else {
      emit(ChangePostImageErrorState());
    }
  }

  void createPost({
    required String date,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      dateTime: date,
      image: userData!.image,
      name: userData!.name,
      postImage: postImage ?? '',
      text: text,
      uid: userData!.uid,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPostImage({
    required String date,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file('${postImage!.path}').pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) => {
                createPost(
                  date: date,
                  text: text,
                  postImage: value,
                )
              })
          .catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void removePhoto() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(
            PostModel.fromJson(element.data()),
          );
        }).catchError((error) {});
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userData!.uid)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    emit(AppGetAllUsersLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userData!.uid)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(AppGetAllUsersSuccessState());
      }).catchError((error) {
        emit(AppGetAllUsersErrorState(error.toString()));
      });
  }

  
}
