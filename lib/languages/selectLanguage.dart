import 'package:shared_preferences/shared_preferences.dart';
class Selectlanguage{
  static setLang([lang = 'en'])async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('lang', lang);
  }
 static Future<String> getLang()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('lang');
  }

}