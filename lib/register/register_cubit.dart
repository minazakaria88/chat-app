




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/register/register_state.dart';

import '../shared/user_model.dart';


class RegisterCubit extends Cubit<RegisterState>
{

  RegisterCubit():super(RegisterInitState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool obscure =true;

  void updateObscure()
  {
    obscure=!obscure;
    emit(RegisterInitState());
  }

  TextEditingController nameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();


  void userRegister({
    String ? name,
    String ? password,
    String ? phone,
    String ? email,
  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!).then((value) {
      createUser(
        name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid,
      );
      emit(RegisterSuccessState());
    }).catchError((error){

      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    String ?name,
    String ?email,
    String ?uId,
    String ? phone,
  })
  {
    UserModel model=UserModel(uId, email, name, phone);
    FirebaseFirestore.instance.collection('users').doc(uId).set(
      model.toMap()
    ).then((value) {
      emit(RegisterSuccessState());
    }).catchError((error){
      print(error.toString());
    });




  }


}