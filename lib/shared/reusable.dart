
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color defaultColor = Colors.purple;

Widget newTextForm({
  String label='',
  IconData? iconData,
  IconData? iconData1,
  bool? obscure,
  String  hint='',
  TextEditingController? controller,
  Function? function,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value)
        {
          if(value!.isEmpty) {
            return 'required';
          }
          return null;
        },
        controller: controller,
        obscureText: obscure!,
        decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            iconData,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              iconData1,
              color: defaultColor,
            ),
            onPressed: () {
              function!();
            },
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultColor,
            ),
          ),
        ),
      ),
    );

Widget myButton({
  String? text,
  Function? function,
}) =>
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: MaterialButton(
            color: defaultColor,
            child: Text(
              text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            onPressed: () {
              function!();
            }),
      ),
    );

void goTo({context, screen}) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ));

void makeToast({
  String ? msg,
  ErrorsState  ? errorsState,
})
{
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: setColor(errorsState!),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

String uId='';

enum ErrorsState
{
  success,
  failed,
}

Color setColor(ErrorsState m)
{
  Color ? color;
  if(m==ErrorsState.failed)
    {
      color=Colors.red;
    }
  else
    {
      color=Colors.green;
    }
  return color;
}

Widget progress()=>const Center(child: CircularProgressIndicator(
  color: Colors.purple,
));