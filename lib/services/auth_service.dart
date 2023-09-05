
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:learning_space/configs/endpoints.dart';
import 'package:learning_space/services/api_service.dart';
import 'package:learning_space/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
    AuthService();
    Future login(String username, String password) async {
        Map<String, String> params = {
            'username': username,
            'password': password
        };
        try{
            dynamic response = await ApiService().dio.post(Endpoints.LOGIN, data: params, options: Options(
                headers: {
                  'withToken': false
                }
            ));
            dynamic responseBody = await response.data;
            storeToken(responseBody['data']['accessToken']);
            return true;
        }catch(error, t){
            print("error: $error");
            print(t);
        }
    return false;
  }

  Future refreshToken() async {
      try{
        final _preferences = await SharedPreferences.getInstance();
        var token = _preferences.getString("access_token");
        if(token == null){
          return false;
        }
        var response = await ApiService().dio.post(Endpoints.LOGIN);
        var responseBody = await response.data;
        storeToken(responseBody['data']['access_token']);
        return true;
      }catch(e){
        // TODO
      }
      return false;
  }

  storeToken(accessToken) async {
      print(accessToken);
        final _preferences = await SharedPreferences.getInstance();
        await _preferences.setString('access_token', accessToken);
  }

  getToken() async {
    final _preferences = await SharedPreferences.getInstance();
    var token = _preferences.getString("access_token");
    if(token != null){
      var hasExpired = JwtDecoder.isExpired(token);
      if(!hasExpired){
        return token;
      }
    }
    // Otherwise logged out
     await logout();
  }

  isValidTokenExist() async {
    final _preferences = await SharedPreferences.getInstance();
    var token = _preferences.getString("access_token");
    if(token != null){
      var hasExpired = JwtDecoder.isExpired(token);
      if(!hasExpired){
        return token;
      }
    }
    return false;
  }

  getDecodedToken() async {
      dynamic token = await isValidTokenExist();
      if(token is bool){
        return false;
      }
      return JwtDecoder.decode(token);
  }

  logout() async {
    final _preferences = await SharedPreferences.getInstance();
    await _preferences.remove("access_token");
    NavigationService.navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
  }
}