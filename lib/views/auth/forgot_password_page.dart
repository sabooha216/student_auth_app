import 'package:flutter/material.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/form_validators.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final AuthController authController;
  const ForgotPasswordPage({super.key, required this.authController});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _handleSendCode() async {
    if (_formKey.currentState!.validate()) {
      final identifier = _identifierController.text.trim();
      final success = await widget.authController.sendPasswordResetCode(identifier);
      if (!mounted) return;

      if (success) {
        // SnackBar أخضر كما مطلوب
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال رمز التحقق بنجاح إلى بريدك الأكاديمي'),
            backgroundColor: Colors.green,
          ),
        );

        // التوجيه التلقائي لشاشة تعيين كلمة المرور
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordPage(
              authController: widget.authController,
              identifier: identifier,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.authController.errorMessage ?? 'تعذر إرسال الرمز'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('استعادة كلمة المرور')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة توجيهية أعلى الشاشة
              Card(
                color: Colors.blue.shade50,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.blue.shade200),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'الرجاء إدخال البريد الإلكتروني أو الرقم الأكاديمي المرتبط بحسابك. سنقوم بإرسال رمز تحقق مكون من 6 أرقام لتمكينك من إعادة تعيين كلمة المرور.',
                    style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _identifierController,
                      decoration: const InputDecoration(
                        labelText: 'البريد أو الرقم الأكاديمي',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      validator: FormValidators.validateIdentifier,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // زر إرسال رمز التحقق
              ListenableBuilder(
                listenable: widget.authController,
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: widget.authController.isLoading ? null : _handleSendCode,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: widget.authController.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('إرسال رمز التحقق', style: TextStyle(fontSize: 16)),
                  );
                },
              ),
              const SizedBox(height: 12),

              // زر العودة لتسجيل الدخول
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('العودة لتسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}