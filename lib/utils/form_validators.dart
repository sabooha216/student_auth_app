class FormValidators {
  // التحقق من البريد الإلكتروني (Regex قياسي)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return 'صيغة البريد الإلكتروني غير صالحة';
    }
    return null;
  }

  // المعرف الأكاديمي أو البريد (≥ 5 خانات)
  static String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'المعرف الأكاديمي أو البريد مطلوب';
    }
    if (value.trim().length < 5) {
      return 'يجب ألا يقل المعرف عن 5 محارف';
    }
    return null;
  }

  // الاسم الكامل (≥ 3 محارف)
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم الكامل مطلوب';
    }
    if (value.trim().length < 3) {
      return 'الاسم يجب أن يتكون من 3 محارف على الأقل';
    }
    return null;
  }

  // الرقم الأكاديمي (أرقام حصراً، 9-10 خانات)
  static String? validateStudentId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرقم الأكاديمي مطلوب';
    }
    final regex = RegExp(r'^\d{9,10}$');
    if (!regex.hasMatch(value.trim())) {
      return 'الرقم الأكاديمي يجب أن يكون أرقاماً حصراً (9 أو 10 خانات)';
    }
    return null;
  }

  // كلمة المرور لتسجيل الدخول (≥ 6 محارف)
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب ألا تقل عن 6 محارف';
    }
    return null;
  }

  // كلمة المرور القوية (≥ 8 محارف + رقم + حرف كبير)
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 8) {
      return 'يجب ألا تقل كلمة المرور عن 8 محارف';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'يجب أن تحتوي على حرف كبير واحد على الأقل (A-Z)';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'يجب أن تحتوي على رقم واحد على الأقل (0-9)';
    }
    return null;
  }

  // تأكيد كلمة المرور
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != originalPassword) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  // رمز التحقق OTP (6 أرقام حصراً)
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رمز التحقق مطلوب';
    }
    final regex = RegExp(r'^\d{6}$');
    if (!regex.hasMatch(value.trim())) {
      return 'رمز التحقق يجب أن يتكون من 6 أرقام حصراً';
    }
    return null;
  }
}