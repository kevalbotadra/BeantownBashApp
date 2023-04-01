import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class LoginRedirect extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}

class SubmitSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SubmitSignUp(
      {required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}

class RegistrationRedirect extends AuthEvent {}
