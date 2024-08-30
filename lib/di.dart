import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:job/features/auth/repos/auth_repo.dart';

import 'features/Home/repos/Home_repo.dart';
import 'features/home/controllers/home_controller.dart';

final getIt = GetIt.instance;

Future<void> setup() async {

  // Storage
  // Initialize GetStorage
  await GetStorage.init();

  // Register GetStorage instance
  getIt.registerSingleton<GetStorage>(GetStorage());

  // API 
  final dio = Dio(BaseOptions(
    baseUrl: 'https://jobportal-staging-backend-nh4po.ondigitalocean.app/v1/admin', // Replace with your API base URL
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));
  
  getIt.registerSingleton<Dio>(dio);

  // Auth
  getIt.registerSingleton<AuthRepo>(AuthRepo());
  // getIt.registerSingleton<AuthController>(AuthController());

  // Home
  getIt.registerSingleton<HomeRepo>(HomeRepo());
  // getIt.registerSingleton<HomeController>(HomeController());

}
