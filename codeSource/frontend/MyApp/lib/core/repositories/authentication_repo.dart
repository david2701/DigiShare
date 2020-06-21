import '../models/employee.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class AuthenticationRepo{
  final String endpoint = '${DotEnv().env['API_URL']}/auth';

  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Employee> attemptLogIn(String login, String password) async {
    String url = "$endpoint/login";
    Map body = {'login': login, 'password': password};
    print("login est :$login et password : $password");
    var res = await http.post(url, body: jsonEncode(body), headers: { 'Content-type': 'application/json'});
    if(res.statusCode == 200 || res.statusCode==201)
    {
      print('${this.runtimeType.toString()}:---> authenticated successfully');
      Map jwt = jsonDecode(res.body);
      storage.write(key: 'userId', value: jwt['user']['_id']);
      storage.write(key: 'token', value: jwt['token']);
      return Employee.fromJsonWithPostsIdAndAgency(jwt['user']);
    }else{
      print(':---> login request failed !!!!!!!!!!!!!!!!');
      return null;
    }
  }

}