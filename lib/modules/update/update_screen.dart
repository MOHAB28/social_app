import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constance/colors.dart';
import 'package:social_app/constance/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';

class UpdateScreen extends StatelessWidget {
  var _nameController = TextEditingController();
  var _bioController = TextEditingController();
  var _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userData;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        _nameController.text = userModel!.name!;
        _bioController.text = userModel.bio!;
        _phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
            ),
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).updateUser(
                    name: _nameController.text,
                    bio: _bioController.text,
                    phone: _phoneController.text,
                  );
                },
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserDataLoadingState)
                    SizedBox(
                      height: 5,
                    ),
                  Container(
                    height: 230,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image(
                                image: coverImage != null
                                    ? FileImage(coverImage)
                                    : NetworkImage(
                                        'https://image.freepik.com/free-photo/front-view-educational-objects-arrangement-with-copy-space_23-2148721253.jpg',
                                      ) as ImageProvider,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(IconBroken.Camera),
                                      onPressed: () {
                                        AppCubit.get(context).getCoverImage();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 57,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          'https://image.freepik.com/free-photo/young-beautiful-woman-casual-outfit-isolated-studio_1303-20526.jpg',
                                        )
                                      : FileImage(profileImage) as ImageProvider,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              child: Center(
                                child: IconButton(
                                  icon: Icon(IconBroken.Camera),
                                  onPressed: () {
                                    AppCubit.get(context).getProfileImage();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (AppCubit.get(context).profileImage != null ||
                      AppCubit.get(context).coverImage != null)
                    Container(
                      height: 100,
                      child: Row(
                        children: [
                          if (AppCubit.get(context).profileImage != null)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  AppCubit.get(context).updateProfileImage(
                                    name: _nameController.text,
                                    bio: _bioController.text,
                                    phone: _phoneController.text,
                                  );
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: defualtColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Upload Profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          if (AppCubit.get(context).coverImage != null)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  AppCubit.get(context).updateCoverImage(
                                    name: _nameController.text,
                                    bio: _bioController.text,
                                    phone: _phoneController.text,
                                  );
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: defualtColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Upload Cover',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(IconBroken.User),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: 'bio',
                      prefixIcon: Icon(IconBroken.Chat),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(IconBroken.Call),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
