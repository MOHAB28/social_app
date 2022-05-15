import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constance/components.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/cubit/states.dart';

class SocialChatCubit extends Cubit<SocialChatStates> {
  SocialChatCubit() : super(SocialChatInitialState());

  static SocialChatCubit get(context) => BlocProvider.of(context);

  TextEditingController messageController = TextEditingController();

  void sendMessage({
    required UserModel userModel,
  }) {
    emit(SocialSendChatLoadingState());


    MessageModel messageModel = MessageModel(
      recieverId: userModel.uid,
      senderId: user!.uid,
      text: messageController.text,
      dateTime: DateTime.now().toString(),
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      //emit(SocialSendChatSuccessState());
      saveMessage(
        messageId: value.id,
        messageModel: messageModel,
        userModel: userModel,
      );
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendChatErrorState());
    });
  }

  void saveMessage({
    required UserModel userModel,
    required MessageModel messageModel,
    required String messageId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(user!.uid)
        .collection('messages')
        .doc(messageId)
        .set(messageModel.toMap())
        .then((value) {
      emit(SocialSendChatSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendChatErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required UserModel userModel,
  }) {
    emit(SocialChatLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .orderBy('dateTime', descending: false,)
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialChatSuccessState());
    });
  }
}