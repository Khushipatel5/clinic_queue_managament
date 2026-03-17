import 'package:shared_preferences/shared_preferences.dart';

class SharedprefrencesService{
  SharedPreferences? _sharedPreferences;

  Future<void> init()async{
    if(_sharedPreferences==null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }
  Future<void> saveToken(String token)async{
    await init();
    await _sharedPreferences!.setString('token', token);
  }
  Future<String> getToken()async{
    await init();
    return await _sharedPreferences!.getString('token')??'';
  }
  Future<void> setUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("userId", id);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId");
  }
  Future<void> setClinicId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("clinicId", id);
  }

  Future<int?> getClinicId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("clinicId");
  }
}