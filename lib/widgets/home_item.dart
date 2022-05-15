import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constance/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/post_model.dart';

class ItemFeedsBuilder extends StatelessWidget {
  final PostModel? model;
  final int? index;
  ItemFeedsBuilder({this.model, this.index});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Card(
          elevation: 5.0,
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28.0,
                      backgroundImage: NetworkImage(
                        '${model!.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model!.name}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 9,
                              child: Icon(
                                Icons.done,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${model!.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey[300], height: 1),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  '${model!.text}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16, height: 1.25),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   child: Wrap(
              //     children: [
              //       MaterialButton(
              //         onPressed: () {},
              //         padding: EdgeInsets.only(right: 5),
              //         minWidth: 10,
              //         height: 0,
              //         materialTapTargetSize:
              //             MaterialTapTargetSize.shrinkWrap,
              //         child: Text(
              //           '#software',
              //           style: TextStyle(
              //             color: Colors.blue,
              //           ),
              //         ),
              //       ),
              //       MaterialButton(
              //         onPressed: () {},
              //         padding: EdgeInsets.only(right: 5),
              //         minWidth: 10,
              //         height: 0,
              //         materialTapTargetSize:
              //             MaterialTapTargetSize.shrinkWrap,
              //         child: Text(
              //           '#flutter',
              //           style: TextStyle(
              //             color: Colors.blue,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              if (model!.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model!.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${AppCubit.get(context).likes[index!]}',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '521 comments',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${AppCubit.get(context).userData!.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        child: Text(
                          'Write a comment...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        AppCubit.get(context)
                            .likePost(AppCubit.get(context).postsId[index!]);
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
