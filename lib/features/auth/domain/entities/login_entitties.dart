import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String emailOrPhone;
  final String password;

  const LoginEntity({required this.emailOrPhone, required this.password});

  @override
  List<Object> get props => [emailOrPhone, password];
}
