import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences ? x;

  static Future<SharedPreferences> init()async
  {
    x=await SharedPreferences.getInstance();

    return x!;
  }

  static void setString({
    String ? key,
    String ? value,
})async
  {
   await x!.setString(key!, value!);
  }

  static String ?  getString({
    String ? key,
  })
  {
    return x!.getString(key!);
  }

}