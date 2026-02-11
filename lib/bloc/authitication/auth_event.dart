abstract class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  String userName;
  String password;

  AuthLoginRequest(this.userName, this.password);
}

class AuthRegisterRequest extends AuthEvent {
  String userName;
  String password;
  String passwordConfirm;

  AuthRegisterRequest(this.userName, this.password, this.passwordConfirm);
}
