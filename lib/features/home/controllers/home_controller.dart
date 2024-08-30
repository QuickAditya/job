import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:job/features/home/models/job_model.dart';
import 'package:either_dart/either.dart';

class HomeController with ChangeNotifier {
  JobModel? jobModel;
  int currentPage = 1;
  int pageLength = 5;

  updateCurrentPage(int val) {
    currentPage = val;
    notifyListeners();
  }

  updatePageLength(int val) {
    pageLength = val;
    notifyListeners();
  }

  Future<Either<String, bool>> fetchJobData() async {
    try {
      var headers = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcGFydG5lcmFwaS5vcHRpbWhpcmUuY29tXC8iLCJhdWQiOiJodHRwczpcL1wvcGFydG5lcmFwaS5vcHRpbWhpcmUuY29tXC8iLCJpYXQiOjE3MjQ0OTU0ODIsIm5iZiI6MTcyNDQ5NTQ4MiwiZGF0YSI6eyJyZWZfdXNlcl9pZCI6IjQyMTAzMiIsInJlZl91c2VyX2lwIjoiNDkuNDMuNy4yMzUiLCJyZWZfZmlyc3RfbmFtZSI6IlNhZ2FyIiwicmVmX2xhc3RfbmFtZSI6Ik5lZXJhaiIsInJlZl91c2VyX2VtYWlsIjoidml0cHJvamVjdG1hbmFnZXJAeWFob28uY29tIiwicmVmX2ltYWdlIjpudWxsLCJyZWZfdXNlcl90eXBlIjoib3RoZXIifX0.7IyHBYruRUwiQ5j5vscZcZJKD28wQieifWx7zigiDQE',
        'Cookie': 'ci_session=41ip78h92q0a52te4gkg2vr9lrp7cf04'
      };
      var data = '''''';
      var dio = Dio();
      var response = await dio.request(
        'https://partnerapi.optimhire.com/v1/partner/job-list/?page=$currentPage&size=$pageLength',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        jobModel = JobModel.fromJson(response.data as Map<String, dynamic>);
        log(jobModel!.data!.job!.map((e) => e.jobId).toList().toString(),
            name: 'Jobs');
        notifyListeners();
        return const Right(true);
      } else {
        return const Left('Login failed');
      }
    } catch (e) {
      return const Left('Login failed');
    }
  }
}
