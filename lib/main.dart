
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/login/login_screen.dart';
import 'package:lol/shared/cahehelper.dart';
import 'package:lol/shared/reusable.dart';

import 'app/appcubit.dart';
import 'app/home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget screen=Login();
  if(CacheHelper.getString(key: 'uId')!=null)
    {
      uId=CacheHelper.getString(key: 'uId')!;
      screen=const Home();
    }


  runApp(
     BlocProvider(
       create: (context) => AppCubit()..getAllUsers(),
       child: MaterialApp(
        home:  screen,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.purple,
            titleTextStyle: TextStyle(
              color: Colors.white
            ),
          ),
        ),
           ),
     )
  );
}

