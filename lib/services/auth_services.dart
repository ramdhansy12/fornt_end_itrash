import 'dart:convert';

import 'package:itrash_skripsi/model/model.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String baseUrl = 'https://api.foodmarket.technosolution.site/api';

  Future<User> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({'email': email, 'password': password});

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    // print(url);

    if (response.statusCode == 200) {
      var dataResponse = jsonDecode(response.body);

      User user = User.fromJson(dataResponse['user']);

      user.token = 'Bearer ' + dataResponse['access_token'];

      return user;
    } else {
      throw Exception('gagal login');
    }
  }
}
