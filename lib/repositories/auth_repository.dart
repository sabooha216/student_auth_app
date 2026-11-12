import '../models/user_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

abstract class AuthRepository {
  Future<UserModel> login(LoginRequest request);
  Future<void> register(RegisterRequest request);
  Future<void> sendPasswordResetCode(String identifier);
  Future<void> resetPassword({required String otp, required String newPassword});
}