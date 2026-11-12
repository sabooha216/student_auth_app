import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'repositories/auth_repository_impl.dart';
import 'views/auth/login_page.dart';

void main() {
  runApp(const StudentAuthApp());
}

class StudentAuthApp extends StatelessWidget {
  const StudentAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    // تهيئة المستودع والمتحكم بناءً على نمط Repository + MVC
    final authRepository = AuthRepositoryImpl();
    final authController = AuthController(authRepository: authRepository);

    return MaterialApp(
      title: 'نظام المصادقة الطلابي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      locale: const Locale('ar', ''),
      home: LoginPage(authController: authController),
    );
  }
}