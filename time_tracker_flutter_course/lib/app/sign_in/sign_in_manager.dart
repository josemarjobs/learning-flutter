import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:timetrackerfluttercourse/services/auth.dart';

class SignInManager {
  SignInManager({
    @required this.auth,
    @required this.isLoading,
  });

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

//  final StreamController<bool> _isLoadingController = StreamController<bool>();
//  Stream<bool> get isLoadingStream => _isLoadingController.stream;
//  void dispose() {
//    _isLoadingController.close();
//  }
//  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() singInMethod) async {
    try {
//      _setIsLoading(true);
      isLoading.value = true;
      return await singInMethod();
    } catch (e) {
//      _setIsLoading(false);
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async => _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}
