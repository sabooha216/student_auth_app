class RegisterRequest {
  final String fullName;
  final String studentId;
  final String email;
  final String password;
  final bool acceptTerms;

  RegisterRequest({
    required this.fullName,
    required this.studentId,
    required this.email,
    required this.password,
    required this.acceptTerms,
  });
}