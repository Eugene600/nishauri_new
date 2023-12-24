import 'dart:ffi';

import 'package:nishauri/src/features/user/data/models/user.dart';

class AuthState {
  final String token;
  final String refresh;
  final String user;
  final bool isAccountVerified;
  final bool isProfileComplete;

  AuthState({
    required this.token,
    required this.user,
    required this.isAccountVerified,
    required this.isProfileComplete,
    required this.refresh,
  });

  factory AuthState.defaultState() {
    return AuthState(
      token: "",
      user: '',
      isAccountVerified: true,
      isProfileComplete: true,
      refresh: ""
    );
  }

  factory AuthState.fromResponse({
    String token = "",
    String refresh = "",
    String user = '',
    bool isAccountVerified = false,
    bool isProfileComplete = false,
  }) {
    return AuthState(
      token: token,
      refresh: refresh,
      user: user ,
      isAccountVerified: isAccountVerified,
      isProfileComplete: isProfileComplete,
    );
  }

  AuthState copyWith({
    String? token,
    String? refresh,
    String? user,
    bool? isAccountVerified,
    bool? isProfileComplete,
  }) =>
      AuthState(
        token: token ?? this.token,
        refresh: refresh ?? this.refresh,
        user: user ?? this.user,
        isAccountVerified: isAccountVerified ?? this.isAccountVerified,
        isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      );

  @override
  String toString() {
    return "AuthState<userId:$user, token:$token, isAccountVerified: $isAccountVerified, isProfileComplete: $isProfileComplete>";
  }
}
