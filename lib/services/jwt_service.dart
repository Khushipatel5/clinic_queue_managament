import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JWTtokenService{
  JWTtokenService._();

  static Future<dynamic> gettokendata()async{
    String token=await SharedprefrencesService().getToken();
    return JwtDecoder.isExpired(token)?null:JwtDecoder.decode(token);
  }

  static Future<String?> finduserRole()async
  {
    String token=await SharedprefrencesService().getToken();
    // print(JwtDecoder.decode(token));

    if(JwtDecoder.isExpired(token)){
      return null;
    }else{
      if(JwtDecoder.decode(token)['role']=='admin'){
        return 'admin';
      }
      else if(JwtDecoder.decode(token)['role']=='doctor'){
        return 'doctor';
      }
      else if(JwtDecoder.decode(token)['role']=='receptionist'){
        return 'receptionist';
      }
      else {
        return 'patient';
      }

    }

  }
}