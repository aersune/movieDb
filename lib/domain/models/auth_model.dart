

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/api/api_client.dart';
import 'package:movie_db/domain/api/data_providers/session_data_provider.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:provider/provider.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider =  SessionDataProvider();

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isAuthProgress = false;
  bool get canStartAuth => _isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async{
    final login = loginController.text;
    final password = passwordController.text;
    if(login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try{
       sessionId = await  _apiClient.auth(username: login, password: password);
    } catch(e){
        _errorMessage = 'Неправильный логин или пароль';
    }
    if(_errorMessage != null ){
      notifyListeners();
      return;
    }
    if(sessionId == null){
      _errorMessage = 'Неизвестная ошибка повторите попытку';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    // _isAuthProgress = false;
    // Provider.of(context,listen: false);
    unawaited(context.read<MoviesProvider>().logged());

    context.go('/home');
  }

}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  const AuthProvider({super.key,required this.model, required super.child}) : super(notifier: model);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }


}

