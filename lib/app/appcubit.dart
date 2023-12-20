

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/app/appstate.dart';
import 'package:lol/shared/reusable.dart';

import '../shared/messagemodel.dart';
import '../shared/user_model.dart';

class AppCubit extends Cubit<AppState>
{
  AppCubit():super(AppInitState());

  static AppCubit get(context)=>BlocProvider.of(context);


  List<UserModel> users=[];

  void getAllUsers()
  {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for(var i in value.docs)
        {
          if(i.data()['uId']!=uId)
            {
              users.add(UserModel.fill(i.data()));
            }
        }
      emit(AppGetDataSuccessState());
    }).catchError((error){
      emit(AppGetDataErrorState(error.toString()));
    });
  }

  List<MessageModel> messages=[];

  void getMessages({String ? userId})
  {
    messages=[];
    emit(AppSendMessageSuccessState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .collection('messages')
        .doc(userId)
         .collection('chats')
        .orderBy('dateTIme')
        .snapshots()
        .listen((event) {
          messages=[];
         for(var element in event.docs)
           {
             messages.add(MessageModel.fromJson(element.data()));
             emit(AppGetMessageSuccessState());
           }
    });

  }

  void sendMessages({
    String ? userId,
    String ? message,
    String ? datetime,
  })
  {
    MessageModel model=MessageModel(
      dateTIme: datetime,
      receiverId: userId,
      text: message,
      senderId: uId,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .collection('messages')
        .doc(userId)
        .collection('chats')
        .add(model.toMap())
        .then((value) {
          emit(AppSendMessageSuccessState());
    });

    FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .collection('messages')
        .doc(uId)
        .collection('chats')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    });


  }

  TextEditingController controller=TextEditingController();


}