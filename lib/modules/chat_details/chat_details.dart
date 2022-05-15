import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/constance/components.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/cubit/cubit.dart';
import 'package:social_app/modules/chat_details/cubit/states.dart';

class ChatDetails extends StatelessWidget {
  UserModel userModel;

  ChatDetails({
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialChatCubit()
        ..getMessages(
          userModel: userModel,
        ),
      child: BlocConsumer<SocialChatCubit, SocialChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      userModel.image!,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    userModel.name!,
                  ),
                ],
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: SocialChatCubit.get(context).messages.length > 0 
                      ? 
                       ListView.separated(
                          itemBuilder: (context, index) {
                            MessageModel model =
                                SocialChatCubit.get(context).messages[index];

                            if (model.senderId == user!.uid)
                              return MyMessage(
                                model: model,
                              );

                            return UserMessage(
                              model: model,
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 16.0,
                          ),
                          itemCount:
                              SocialChatCubit.get(context).messages.length,
                        ) :Center(child: CupertinoActivityIndicator()),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller:
                              SocialChatCubit.get(context).messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'type a message ...',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          SocialChatCubit.get(context).sendMessage(
                            userModel: this.userModel,
                          );
                        },
                        child: Icon(
                          Icons.send,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  MessageModel model;

  UserMessage({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              model.text!,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  MessageModel model;

  MyMessage({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              model.text!,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
