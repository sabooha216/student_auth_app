class LoginRequest {
  final String identifier;
  final String password;
  final bool rememberMe;

  LoginRequest({
    required this.identifier,
    required this.password,
    required this.rememberMe,
  });
}
