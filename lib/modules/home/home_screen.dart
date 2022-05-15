import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/widgets/home_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return AppCubit.get(context).posts.length > 0 && AppCubit.get(context).userData != null
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Card(
                            elevation: 5.0,
                            child: Image(
                              image: NetworkImage(
                                'https://image.freepik.com/free-photo/funny-girl-black-sneakers-white-socks-posing-with-pink-interior-listening-favorite-song-charming-african-woman-trendy-jeans-sitting-chair_197531-4106.jpg',
                              ),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with friends',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) => ItemFeedsBuilder(
                        model: AppCubit.get(context).posts[i],
                        index : i,
                      ),
                      itemCount: AppCubit.get(context).posts.length,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
