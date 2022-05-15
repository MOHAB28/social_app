import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constance/components.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class SocialAppLoginCubit extends Cubit<SocialAppLoginStates> {
  SocialAppLoginCubit() : super(SocialAppLoginInitialState());
  static SocialAppLoginCubit get(context) => BlocProvider.of(context);

  UserCredential? userCredential;
  void login({
    required String email,
    required String password,
  }) {
    emit(SocialAppLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print('ther is $uid');
      emit(SocialAppLoginSuccessState(uid));
    }).catchError((error){
      print(error.toString());
      emit(SocialAppLoginErrorState(error));
    });
  }

    var isVisible = true;
  late IconData visibile = Icons.visibility_outlined;
  void changeVisibleState() {
    isVisible = !isVisible;
    visibile =
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialAppLoginnVisibleState());
  }
}
