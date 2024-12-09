import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiAuth {
  static final _apiKey = dotenv.get('API_KEY');
  final dio = Dio();

  Future<String> auth({required String username, required String password}) async {
    final token = await _makeToken();
    final validToken = await _validUser(requestToken: token, username: username, password: password);
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Future<String> _makeSession({required String requestToken}) async {
    final String url = 'https://api.themoviedb.org/3/authentication/session/new?api_key=$_apiKey';

    final Map<String, dynamic> data = {"request_token": requestToken};
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // return  responseData['request_token'];
        if (responseData.containsKey('session_id') && responseData['session_id'] != null) {
          return responseData['session_id'] as String;
        } else {
          throw Exception('Session Id is null or not found');
        }
      } else {
        throw Exception('Failed to get Session Id');
      }
    } catch (e) {
      throw Exception('Failed to get SessionId: $e');
    }
  }

  Future<String> _validUser({required String requestToken, required String username, required String password}) async {
    final String url = 'https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$_apiKey';

    final Map<String, dynamic> data = {"username": username, "password": password, "request_token": requestToken};

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['request_token'];
      } else {
        throw Exception('Failed to validate request token');
      }
    } catch (e) {
      throw Exception('Failed to validate request token: $e');
    }
  }

  Future<String> _makeToken() async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/authentication/token/new',
        queryParameters: {
          'api_key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        return response.data['request_token'];
      } else {
        throw Exception('Failed to get request token');
      }
    } catch (e) {
      throw Exception('Failed to get request token: $e');
    }
  }
}
