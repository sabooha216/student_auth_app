class UserModel {
  final String fullName;
  final String studentId;
  final String email;

  UserModel({
    required this.fullName,
    required this.studentId,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'studentId': studentId,
        'email': email,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json['fullName'] ?? '',
        studentId: json['studentId'] ?? '',
        email: json['email'] ?? '',
      );
}