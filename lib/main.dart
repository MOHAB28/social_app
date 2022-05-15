import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';

import 'constance/colors.dart';
import 'constance/components.dart';
import 'cubit/bloc_observer.dart';
import 'helpers/cache_helpers.dart';
import 'layout/layout.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  

  print("Handling a background message: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  uid = CacheHelper.getString(key: 'uid');
  user = FirebaseAuth.instance.currentUser;

  var token = await FirebaseMessaging.instance.getToken();
  print('this token : $token');

  FirebaseMessaging.onMessage.listen((event) {
    print('Got a message whilst in the foreground!');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) { 
    print('when you open the app');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (user != null) print(user!.uid);
  Widget widget = RegisterScreen();
  if (uid != null) {
    widget = HomeLayout();
  } else {
    widget = RegisterScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getPosts(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            home: widget,
          );
        },
      ),
    );
  }
}
