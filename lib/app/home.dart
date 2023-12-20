

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/app/appcubit.dart';
import 'package:lol/app/appstate.dart';
import 'package:lol/shared/reusable.dart';
import 'package:lol/shared/user_model.dart';

import 'details.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
     listener: (context, state) {

     },
      builder: (context, state) {
       var list=AppCubit.get(context).users;
        return Scaffold(
          appBar: AppBar(
            title: const Text('users'),
          ),
          body:list.isEmpty? const Center(child: Text('no users ')): Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (context, index) => listItem(list[index],context),
                separatorBuilder: (context, index) => Container(
                  height: 1,
                ),
                 itemCount: list.length
            ),
          ),
        );
      },
    );
  }
}
Widget listItem(UserModel model,context)=>InkWell(
  onTap: ()
  {
    AppCubit.get(context).getMessages(userId: model.uId!);
    goTo(
      context: context,
      screen: Chats(model),
    );
  },
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 5,
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.purple,
              radius: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);