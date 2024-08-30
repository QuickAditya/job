class RegisterResponseModel {
  final bool status;
  final int subCode;
  final String message;
  final String error;
  final RegisterUser items;

  RegisterResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  // Factory constructor to create a RegisterResponseModel from a JSON map
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json['status'] as bool,
      subCode: json['subCode'] as int,
      message: json['message'] as String,
      error: json['error'] as String,
      items: RegisterUser.fromJson(json['items'] as Map<String, dynamic>),
    );
  }

  // Method to convert a RegisterResponseModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'subCode': subCode,
      'message': message,
      'error': error,
      'items': items.toJson(),
    };
  }
}

class RegisterUser {
  String? name;
  final String email;
  String? number;
  final String id;
  final String token;

  RegisterUser({
    required this.name,
    required this.email,
    required this.number,
    required this.id,
    required this.token,
  });

  // Factory constructor to create a RegisterUser from a JSON map
  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
      name: (json['name'] ?? '') as String,
      email: json['email'] as String,
      number: (json['number'] ?? '').toString(),
      id: (json['_id'] ?? json['userId']) as String,
      token: (json['token'] ?? '') as String,
    );
  }

  // Method to convert a RegisterUser to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      '_id': id,
      'token': token,
    };
  }
}
