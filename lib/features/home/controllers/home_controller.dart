import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/home/models/job_model.dart';
import 'package:either_dart/either.dart';
import 'package:job/features/home/models/jobbybobId.dart';

class HomeController with ChangeNotifier {
  JobModel? jobModel;
  int currentPage = 1;
  int pageLength = 5;
  bool isLoading = false;

  // HomeController() {
  //   log('iniit>>');
  //   jobcardbyJobidad(216075);
  // }

  SaveJobNotifier() {
    loadSavedJobs(); // Load saved jobs when the notifier is created
  }

  updateCurrentPage(int val) {
    currentPage = val;
    notifyListeners();
  }

  updatePageLength(int val) {
    pageLength = val;
    notifyListeners();
  }
  fetchHomePageData(BuildContext context) async {
    // setState(() {
      isLoading = true;
      notifyListeners();
    // });
    final result = 
    // await Provider.of<HomeController>(context, listen: false)
    //     .
        fetchJobData();
    result.fold(
      (error) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Job Listings'),
        ),
        child: Center(
          child: CupertinoAlertDialog(
            title: const Text('Error'),
            content: Text(error),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      (success) {
      isLoading = false;
      notifyListeners();
        // setState(() {
        //   isLoading = true;
        // });
      },
    );
  }

  List<Job> saveJobList = [];
  final getStorage = GetIt.instance<GetStorage>();
  void addtoSave(Job savedjob) {
    // getStorage.write('jobID', jobId);
    saveJobList.add(savedjob);
    saveToStorage(saveJobList); // Save the updated list to storage
    log('stored jobID' + getStorage.read('jobID').toString());
    log('saveJobList length: ' + saveJobList.length.toString());

    notifyListeners();
  }

  void saveToStorage(List<dynamic> savedJobsJson) {
    savedJobsJson = saveJobList.map((job) => jsonEncode(job.toJson())).toList();
    getStorage.write('savedJobs', savedJobsJson);
    log('saveJobList length: ' + savedJobsJson.length.toString());
  }

  void loadSavedJobs() {
    log('loadSavedJobs');
    List<String>? savedJobsJson = getStorage.read<List<String>>('savedJobs');
    if (savedJobsJson != null) {
      saveJobList = savedJobsJson
          .map((jobJson) => Job.fromJson(jsonDecode(jobJson)))
          .toList();
      notifyListeners();
    }
  }

  void removeJob(Job job) {
    // saveJobList.remove(job);

    log('remove card');
    log('saveJobList length after removing jobcard :: ' +
        saveJobList.length.toString());
    notifyListeners();
  }

  List<Job> JobList = [];
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
        JobList.addAll(jobModel!.data!.job!);
        log('JobList  : ' + JobList.length.toString());
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

  // var savejobsList = [];
  JobData? JobListbyID;
  Future jobcardbyJobid(int jobId) async {
    try {
      var headers = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcGFydG5lcmFwaS5vcHRpbWhpcmUuY29tXC8iLCJhdWQiOiJodHRwczpcL1wvcGFydG5lcmFwaS5vcHRpbWhpcmUuY29tXC8iLCJpYXQiOjE3MjQ0OTU0ODIsIm5iZiI6MTcyNDQ5NTQ4MiwiZGF0YSI6eyJyZWZfdXNlcl9pZCI6IjQyMTAzMiIsInJlZl91c2VyX2lwIjoiNDkuNDMuNy4yMzUiLCJyZWZfZmlyc3RfbmFtZSI6IlNhZ2FyIiwicmVmX2xhc3RfbmFtZSI6Ik5lZXJhaiIsInJlZl91c2VyX2VtYWlsIjoidml0cHJvamVjdG1hbmFnZXJAeWFob28uY29tIiwicmVmX2ltYWdlIjpudWxsLCJyZWZfdXNlcl90eXBlIjoib3RoZXIifX0.7IyHBYruRUwiQ5j5vscZcZJKD28wQieifWx7zigiDQE',
        'Cookie': 'ci_session=41ip78h92q0a52te4gkg2vr9lrp7cf04'
      };
      // var data = '''''';
      var dio = Dio();
      var response = await dio.get(
        'https://partnerapi.optimhire.com/v1/partner/job-description/?job_id=$jobId',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        JobbyjobidModel jobModel =
            JobbyjobidModel.fromJson(response.data as Map<String, dynamic>);

        JobListbyID = (jobModel.data ?? '') as JobData?;

        log('JobList  : ' + JobList.length.toString());
        // log(jobModel!.data!.job!.map((e) => e.jobId).toList().toString(),
        //     name: 'Jobs');
        notifyListeners();

        return const Right(true);
      } else {
        return const Left('Login failed');
      }
    } catch (e) {
      return const Left('Login failed');
    }
  }


  Future<JobData?> jobcardbyJobidad(int jobId) async {
    try {
      isLoading = true;
      notifyListeners();
      var headers = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcGFydG5lcmFwaS5vcHRpbWhpcmUuY29tXC8iLCJhdWQiOiJodHRwczpcL1wvcGFydG5lcmFwaS5vcHRpbWhpcmUuY29tXC8iLCJpYXQiOjE3MjQ0OTU0ODIsIm5iZiI6MTcyNDQ5NTQ4MiwiZGF0YSI6eyJyZWZfdXNlcl9pZCI6IjQyMTAzMiIsInJlZl91c2VyX2lwIjoiNDkuNDMuNy4yMzUiLCJyZWZfZmlyc3RfbmFtZSI6IlNhZ2FyIiwicmVmX2xhc3RfbmFtZSI6Ik5lZXJhaiIsInJlZl91c2VyX2VtYWlsIjoidml0cHJvamVjdG1hbmFnZXJAeWFob28uY29tIiwicmVmX2ltYWdlIjpudWxsLCJyZWZfdXNlcl90eXBlIjoib3RoZXIifX0.7IyHBYruRUwiQ5j5vscZcZJKD28wQieifWx7zigiDQE',
        'Cookie': 'ci_session=41ip78h92q0a52te4gkg2vr9lrp7cf04'
      };

      var dio = Dio();
// log('Sending request for job ID: $jobId');
      var response = await dio.get(
        'https://partnerapi.optimhire.com/v1/partner/job-description/?job_id=$jobId',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        JobbyjobidModel jobModel =
            JobbyjobidModel.fromJson(response.data as Map<String, dynamic>);
        JobData? jobData = jobModel.data;
        notifyListeners();
        // log('====>>>>>>> returning: jobData:  ' + jobData!.jobTitle.toString());
        // log('response: ' + response.toString());
        return jobData;
      } else {
        log('Error fetching job with ID $jobId: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      log('Exception occurred: $e');
      return null;
    } finally {
      log('process complete');
      isLoading = false;
      notifyListeners();
    }
  }
}
