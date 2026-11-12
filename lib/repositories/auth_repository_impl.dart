import '../models/user_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 2)); // محاكاة زمن الشبكة
    if (request.identifier == 'error@student.edu') {
      throw Exception('بيانات الاعتماد غير صحيحة');
    }
    return UserModel(
      fullName: 'طالب تجريبي',
      studentId: '123456789',
      email: request.identifier,
    );
  }

  @override
  Future<void> register(RegisterRequest request) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!request.acceptTerms) {
      throw Exception('يجب الموافقة على الشروط والأحكام');
    }
  }

  @override
  Future<void> sendPasswordResetCode(String identifier) async {
    await Future.delayed(const Duration(seconds: 1500)); // 1.5 ثانية
  }

  @override
  Future<void> resetPassword({required String otp, required String newPassword}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (otp != '123456') {
      throw Exception('رمز التحقق غير صحيح (جرب 123456 افتراضياً)');
    }
  }
}
