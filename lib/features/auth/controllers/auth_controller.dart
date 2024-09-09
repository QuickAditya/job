import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/auth/repos/auth_repo.dart';
import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';

import '../models/user_model.dart';

class AuthController with ChangeNotifier {
  final AuthRepo authRepo = GetIt.instance<AuthRepo>();
  final getStorage = GetIt.instance<GetStorage>();
  bool isloading = false;
  Future<Either<String, bool>> login(String email, String password) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await authRepo.login(email, password);
      log("${response.data}", name: 'RAW RESPONSE');
      if (response.statusCode == 200) {
        final responseModel = RegisterResponseModel.fromJson(response.data);

        log("${responseModel.message}, ${responseModel.items.name}");

        getStorage.write('email', email);
        getStorage.write('token', responseModel.items.token);
        getStorage.write('userId', responseModel.items.id);
        getStorage.write('isLogin', true);

        return const Right(true);
      } else {
        return const Left('Login failed');
      }
    } catch (e) {
      return const Left('Login failed');
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<Either<String, bool>> signup(
      String name, String email, String password, String number) async {
    try {
      isloading = true;
      notifyListeners();
      final response = await authRepo.signup(name, email, password, number);
      log("${response.data}", name: 'RAW RESPONSE');
      if (response.statusCode == 200) {
        final responseModel = RegisterResponseModel.fromJson(response.data);

        log("${responseModel.message}, ${responseModel.items.name}");
        getStorage.write('email', email);
        getStorage.write('name', name);
        getStorage.write('number', number);
        getStorage.write('token', responseModel.items.token);
        getStorage.write('userId', responseModel.items.id);
        getStorage.write('isLogin', true);
        return const Right(true);
      } else {
        return const Left('Signup failed');
      }
    } catch (e) {
      return const Left('Signup failed');
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<Either<String, bool>> fetchProfile() async {
    try {
      String email = getStorage.read('email');
      final response = await authRepo.fetchProfile(email);
      log("${response.data}", name: 'RAW RESPONSE');
      if (response.statusCode == 200) {
        final responseModel = RegisterResponseModel.fromJson(response.data);

        log("${responseModel.message}, ${responseModel.items.name}");

        getStorage.write('email', email);
        getStorage.write('name', responseModel.items.name);
        getStorage.write('number', responseModel.items.number);
        getStorage.write('userId', responseModel.items.id);

        return const Right(true);
      } else {
        return const Left('Login failed');
      }
    } catch (e) {
      log(
        "",
        name: "FETCH PROFILE ERROR",
        error: e.toString(),
      );
      return const Left('Login failed');
    }
  }
}
