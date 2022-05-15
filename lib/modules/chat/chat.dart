import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/chat_details/chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var model = AppCubit.get(context).users;
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return AppCubit.get(context).users.length > 0
                ? ListView.separated(
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetails(userModel: model[i],),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28.0,
                                backgroundImage: NetworkImage(
                                  '${model[i].image}',
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${model[i].name}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, i) {
                      return Divider();
                    },
                    itemCount: AppCubit.get(context).users.length,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        );
      },
    );
  }
}
