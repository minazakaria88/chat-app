
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lol/register/register_cubit.dart';
import 'package:lol/register/register_state.dart';


import '../shared/reusable.dart';

class Register extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context, state) {
            if(state is RegisterSuccessState)
              {
                makeToast(
                  errorsState: ErrorsState.success,
                  msg: 'Register Success',
                );
              }

            if(state is RegisterErrorState)
            {
              makeToast(
                errorsState: ErrorsState.failed,
                msg: state.error,
              );
            }
        },
        builder: (context, state) {
          var cubit=RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),

                    newTextForm(
                      label: 'Name',
                      controller: cubit.nameController,
                      iconData: Icons.person,
                      obscure: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    newTextForm(
                      label: 'Email',
                      controller: cubit.emailController,
                      iconData: Icons.email,
                      obscure: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    newTextForm(
                        label: 'Password',
                        controller: cubit.passwordController,
                        obscure: cubit.obscure,
                        iconData: Icons.password,
                        iconData1: Icons.remove_red_eye_outlined,
                        function: ()
                        {
                          cubit.updateObscure();
                        }
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    newTextForm(
                      label: 'phone',
                      controller: cubit.phoneController,
                      obscure: false,
                      iconData: Icons.phone_android,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    if(state is RegisterLoadingState)
                      progress(),
                    myButton(
                        text: 'Register',
                        function: ()
                        {
                          if(formKey.currentState!.validate())
                            {
                              cubit.userRegister(
                                email: cubit.emailController.text,
                                phone: cubit.phoneController.text,
                                name: cubit.nameController.text,
                                password: cubit.passwordController.text,
                              );
                            }
                        }
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
