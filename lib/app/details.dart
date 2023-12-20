import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/app/appcubit.dart';
import 'package:lol/app/appstate.dart';
import 'package:lol/shared/messagemodel.dart';
import 'package:lol/shared/reusable.dart';

import '../shared/user_model.dart';

class Chats extends StatelessWidget {
  final UserModel? model;
  Chats(this.model, {super.key});
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},

      builder: (context, state) {
        var list = AppCubit.get(context).messages;
        return Scaffold(
          appBar: AppBar(
            title: Text(model!.name!),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: list.isEmpty
                      ? const Text('no messages')
                      : ListView.separated(
                         controller: scrollController,
                          itemBuilder: (context, index) {
                            if(list[index].senderId==uId)
                              {
                                return myItem(list[index]);
                              }
                            return hisItem(list[index]);
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 2,
                            );
                          },
                          itemCount: list.length,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: newTextForm(
                          controller: AppCubit.get(context).controller,
                          obscure: false,
                          hint: 'type your message here ...'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.purple,
                      onPressed: () {
                        AppCubit.get(context).sendMessages(
                          userId: model!.uId!,
                          datetime: DateTime.now().toString(),
                          message: AppCubit.get(context).controller.text,
                        );
                        AppCubit.get(context).controller.clear();
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(microseconds: 1),curve: Curves.linear);
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
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

Widget myItem(MessageModel model)=>Align(
  alignment: Alignment.centerRight,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(model.text!,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ),
  ),
);


Widget hisItem(MessageModel model)=>Align(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(model.text!,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ),
  ),
);