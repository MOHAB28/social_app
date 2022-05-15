import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constance/colors.dart';
import 'package:social_app/constance/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';

class AddNewPost extends StatelessWidget {
  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postImage = AppCubit.get(context).postImage;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Create Post',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (AppCubit.get(context).postImage == null) {
                    AppCubit.get(context).createPost(
                      date: DateTime.now().toString(),
                      text: _textController.text,
                    );
                  } else {
                    AppCubit.get(context).createPostImage(
                      date: DateTime.now().toString(),
                      text: _textController.text,
                    );
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: defualtColor,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28.0,
                      backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/young-beautiful-woman-casual-outfit-isolated-studio_1303-20526.jpg',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Hanen Ali',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'What\'s in your mind?...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (AppCubit.get(context).postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image(
                        image: FileImage(postImage!),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                AppCubit.get(context).removePhoto();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          AppCubit.get(context).getpostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '#tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
