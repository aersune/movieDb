// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// class ApiClient {
//   final _client = HttpClient();
//   static const _host = 'https://api.themoviedb.org/3';
//   static final _apiKey = dotenv.get('API_KEY');
//
//
//   Future<String> auth({required String username, required String password,}) async{
//     final token = await makeToken();
//     final validToken = await _validateUser(username: username, password: password, requestToken: token);
//     final sessionId = await _makeSession(requestToken: validToken);
//     return sessionId;
//   }
//
//   Uri _makeUri(String path, [Map<String, dynamic>? parameters ]) {
//   final url =   Uri.parse('$_host/$path');
//   if(parameters != null){
//     return  url.replace(queryParameters: parameters);
//   }else{
//     return url;
//   }
//   }
//
//   Future<String> makeToken() async {
//     final url = _makeUri("/authentication/token/new", <String, dynamic>{'api_key' : _apiKey});
//
//     final request = await _client.getUrl(url);
//     final response = await request.close();
//     final json = (await  response.jsonDecode()) as Map<String , dynamic>;
//     final token = json['request_token'] as String;
//     print('url: $token');
//     print('makeToken: $token');
//     return token;
//   }
//
//   Future<String> _validateUser({required String username, required String password, required String requestToken}) async {
//     final url = _makeUri("/authentication/token/validate_with_login", <String, dynamic>{'api_key' : _apiKey});
//
//     final parameters = <String, dynamic>{
//       'username': username,
//       'password': password,
//       'request_token': requestToken,
//     };
//     final request = await _client.postUrl(url);
//
//
//     request.headers.contentType = ContentType.json;
//     request.write(jsonEncode(parameters));
//     final response = await request.close();
//     final json = (await  response.jsonDecode()) as Map<String , dynamic>;
//     final token = json['request_token'] as String;
//     print('validate user: $token');
//     return token;
//   }
//
//
//   Future<String> _makeSession({required String requestToken}) async {
//     final url = _makeUri("/authentication/session/new", <String, dynamic>{'api_key' : _apiKey});
//
//     final parameters = <String, dynamic>{
//       'request_token': requestToken,
//     };
//     final request = await _client.postUrl(url);
//
//
//     request.headers.contentType = ContentType.json;
//     request.write(jsonEncode(parameters));
//     final response = await request.close();
//     final json = (await  response.jsonDecode()) as Map<String , dynamic>;
//     final sessionId = json['session_id'] as String;
//     print('make session: $sessionId');
//     return sessionId;
//   }
// }
//
// extension HttpClientResponseJsonDecode on HttpClientResponse {
//   Future<dynamic> jsonDecode() async{
//     return transform(utf8.decoder).toList().then((value) => value.join()).then<dynamic>((val) => json.decode(val));
//   }
// }
//
//
