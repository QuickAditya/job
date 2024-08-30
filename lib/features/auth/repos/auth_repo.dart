import 'package:dio/dio.dart';
import 'package:job/repositories/api_repository.dart';

class AuthRepo {
  Future<Response> login(String email, String password) {
    return ApiRepository.postBody('/login', {
      'email': email,
      'password': password,
    });
  }

  Future<Response> signup(
      String name, String email, String password, String number) {
    return ApiRepository.postBody('/signup', {
      'name': name,
      'email': email,
      'password': password,
      'number': number,
    });
  }

  Future<Response> fetchProfile(String email) {
    return ApiRepository.getApi('/getUserProfile/$email', needToken: true);
  }
}
