import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/home.dart';
import '../register/register_screen.dart';
import '../shared/reusable.dart';
import 'login_cubit.dart';
import 'login_state.dart';


class Login extends StatelessWidget {

   var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context, state) {
          if(state is LoginSuccessState)
          {
            makeToast(
              errorsState: ErrorsState.success,
              msg: 'Register Success',
            );
            goTo(
              context: context,
              screen: const Home(),
            );
          }

          if(state is LoginErrorState)
          {
            makeToast(
              errorsState: ErrorsState.failed,
              msg: state.error,
            );
          }
        },
        builder: (context, state) {
          var cubit=LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
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
                      controller: cubit.emailController,
                      label: 'Email',
                      iconData: Icons.email,
                      obscure: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    newTextForm(
                        controller: cubit.passwordController,
                        label: 'Password',
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
                    if(state is LoginLoadingState)
                      progress(),

                    myButton(
                        text: 'Login',
                        function: ()
                        {
                          if(formKey.currentState!.validate())
                            {
                              cubit.userLogin(
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                                context: context,
                              );
                            }
                        }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text('Don\'t have an Account'),
                        TextButton(
                          onPressed: ()
                          {
                            goTo(
                              context: context,
                              screen:  Register(),
                            );
                          },
                          child: const Text('Register now'),
                        ),
                      ],
                    )
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
