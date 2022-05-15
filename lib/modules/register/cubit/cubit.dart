import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialAppRegisterCubit extends Cubit<SocialAppRegisterStates> {
  SocialAppRegisterCubit() : super(SocialAppRegisterInitialState());
  static SocialAppRegisterCubit get(context) => BlocProvider.of(context);

  void register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialAppRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(email: email, name: name, phone: phone, uid: value.user!.uid);
    }).catchError((error) {
      emit(SocialAppRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uid,
  }) {
    emit(SocialAppCreateUserLoadingState());
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uid: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SocialAppCreateUserSuccessState(uid));
    }).catchError((error) {
      emit(SocialAppCreateUserErrorState(error.toString()));
    });
  }

  var isVisible = true;
  late IconData visibile = Icons.visibility_outlined;
  void changeVisibleState() {
    isVisible = !isVisible;
    visibile =
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialAppRegisterVisibleState());
  }
}
