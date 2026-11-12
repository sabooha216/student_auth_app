import 'package:flutter/material.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/form_validators.dart';

class ResetPasswordPage extends StatefulWidget {
  final AuthController authController;
  final String identifier;

  const ResetPasswordPage({
    super.key,
    required this.authController,
    required this.identifier,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      final success = await widget.authController.resetPassword(
        otp: _otpController.text.trim(),
        newPassword: _newPasswordController.text,
      );

      if (!mounted) return;

      if (success) {
        // نافذة تأكيد نجاح التحديث والتوجيه لشاشة الدخول
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Text('تم التحديث بنجاح'),
            content: const Text('تم تغيير كلمة المرور الأكاديمية بنجاح. يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx); // إغلاق النافذة
                  // العودة لشاشة تسجيل الدخول الرئيسية وإزالة الشاشات السابقة
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('الذهاب لتسجيل الدخول'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.authController.errorMessage ?? 'فشل تحديث كلمة المرور'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعيين كلمة المرور الجديدة')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'أدخل رمز التحقق (OTP) المُرسل إلى: ${widget.identifier}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // حقل رمز التحقق (OTP) 6 أرقام
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'رمز التحقق (6 أرقام)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_clock),
                      counterText: '',
                    ),
                    validator: FormValidators.validateOtp,
                  ),
                  const SizedBox(height: 16),

                  // حقل كلمة المرور الجديدة
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور الجديدة',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: FormValidators.validateStrongPassword,
                  ),
                  const SizedBox(height: 16),

                  // حقل تأكيد كلمة المرور الجديدة
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'تأكيد كلمة المرور الجديدة',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                    ),
                    validator: (val) => FormValidators.validateConfirmPassword(val, _newPasswordController.text),
                  ),
                  const SizedBox(height: 24),

                  // زر تحديث كلمة المرور
                  ListenableBuilder(
                    listenable: widget.authController,
                    builder: (context, child) {
                      return ElevatedButton(
                        onPressed: widget.authController.isLoading ? null : _handleResetPassword,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: widget.authController.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('تحديث كلمة المرور', style: TextStyle(fontSize: 16)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}