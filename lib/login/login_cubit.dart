




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/app/home.dart';
import 'package:lol/login/login_state.dart';
import 'package:lol/shared/cahehelper.dart';
import 'package:lol/shared/reusable.dart';


class LoginCubit extends Cubit<LoginState>
{

  LoginCubit():super(LoginInitState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  bool obscure =true;

  void updateObscure()
  {
    obscure=!obscure;
    emit(LoginInitState());
  }

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void userLogin({
    String ? email,
    String ? password,
    context,

  })
  {
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!).then((value) {
      uId=value.user!.uid;
      CacheHelper.setString(
        key: 'uId',
        value: uId,
      );
      emit(LoginSuccessState());
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(
        builder: (context) =>  const Home(),), (route) => false);
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }


}