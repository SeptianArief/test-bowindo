import 'package:equatable/equatable.dart';
import 'package:test_bowindo/app/login/models/user_model.dart';
import 'package:test_bowindo/shared/api_helper.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final ApiReturnValue data;

  const AuthFailed(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLoaded extends AuthState {
  final UserModel data;

  const AuthLoaded(this.data);

  @override
  List<Object> get props => [data];
}
