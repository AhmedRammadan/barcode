import 'package:shared_preferences/shared_preferences.dart';
class Login{
  static Future<bool> isLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isLogin');
  }
  static setLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLogin', true);
  }
  static setLogout()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLogin', false);
  }
  static setIp(ip)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('Ip', ip);
  }
  static Future<String>  getIp()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('Ip');
  }
}