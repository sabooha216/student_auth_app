import 'package:flutter/material.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // تسجيل الدخول
  Future<bool> login(LoginRequest request) async {
    _setLoading(true);
    _clearError();
    try {
      _currentUser = await _authRepository.login(request);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  // إنشاء حساب
  Future<bool> register(RegisterRequest request) async {
    _setLoading(true);
    _clearError();
    try {
      await _authRepository.register(request);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  // إرسال رمز الاستعادة
  Future<bool> sendPasswordResetCode(String identifier) async {
    _setLoading(true);
    _clearError();
    try {
      await _authRepository.sendPasswordResetCode(identifier);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  // إعادة تعيين كلمة المرور
  Future<bool> resetPassword({required String otp, required String newPassword}) async {
    _setLoading(true);
    _clearError();
    try {
      await _authRepository.resetPassword(otp: otp, newPassword: newPassword);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}