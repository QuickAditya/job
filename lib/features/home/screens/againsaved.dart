import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/home/controllers/home_controller.dart';
import 'package:job/features/home/models/jobbybobId.dart';
import 'package:job/utils/custombutton.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SavingJob extends StatefulWidget {
  const SavingJob({super.key});

  @override
  State<SavingJob> createState() => _SavingJobState();
}

class _SavingJobState extends State<SavingJob> {
  List<JobData> jobs = [];
  // bool isLoading = false;

  @override
  void initState() {
    setState(() {
      // isLoading = true;
    });
    final getStorage = GetIt.instance<GetStorage>();
    final homeController = Provider.of<HomeController>(context, listen: false);

    List<String> savedJobs = getStorage
            .read<List<dynamic>>('savejob')
            ?.map((id) => id.toString())
            .toList() ??
        [];

    savedJobs.forEach((element) async {
      JobData? data = await homeController.jobcardbyJobidad(int.parse(element));
      if (data != null) {
        jobs.add(data);

        getStorage.write('favjoblist', jobs);
        log('stored favjoblist::  ' + getStorage.read('favjoblist').toString());
        log('stored favjoblist length::  ' + jobs.length.toString());
      }
    });
    setState(() {
      // isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log('savedjobs:: ' + getStorage.read('savejob').toString());

    log('jobs: ' + jobs.length.toString());
    return Consumer<HomeController>(
      builder: (_, hcont, __) {
        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Favourite Jobs'),
            ),
            child: SafeArea(
              child: hcont.isLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : jobs.isEmpty
                      ? Center(
                          child: Text('No Saved Jobs'),
                        )
                      : Stack(
                          children: [
                            ListView.builder(
                              itemCount: jobs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final job = jobs[index];
                                return FavJobCard(job: job);
                              },
                            ),
                          ],
                        ),
            ));
      },
    );
  }
}

class FavJobCard extends StatelessWidget {
  final JobData job;

  const FavJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final homeController = Provider.of<HomeController>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: isDarkMode
            ? CupertinoColors.darkBackgroundGray
            : CupertinoColors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job.jobTitle ?? 'No Title',
                    overflow: TextOverflow
                        .ellipsis, // Clip the text without ellipsis if it overflows
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      // color:
                      //     isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    log('remove jobcard');

                    // Get the instance of GetStorage
                    final getStorage = GetIt.instance<GetStorage>();

                    // Attempt to read the stored job IDs
                    dynamic savedJobData = getStorage.read('savejob');
                    List<String> savedJobIds;

                    if (savedJobData is String) {
                      // If the stored data is a string, convert it to a list
                      savedJobIds = [savedJobData];
                    } else if (savedJobData is List) {
                      // If the stored data is already a list, cast it to List<String>
                      savedJobIds = List<String>.from(savedJobData);
                    } else {
                      // If nothing is stored, initialize an empty list
                      savedJobIds = [];
                    }

                    // Remove the job ID from the list if it exists
                    savedJobIds.remove(job.jobId.toString());

                    // Store the updated list back to GetStorage
                    getStorage.write('savejob', savedJobIds);

                    // Log the updated list for debugging purposes
                    log('updated job IDs after removal: ' +
                        savedJobIds.toString());
                    log('after remove jobid lingth::  ' +
                        savedJobIds.length.toString());
                    // Update the UI by removing the job from the local jobs list
                    (context as Element).markNeedsBuild();
                    (context.findAncestorStateOfType<_SavingJobState>())
                        ?.setState(() {
                      (context.findAncestorStateOfType<_SavingJobState>())
                          ?.jobs
                          .remove(job);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    height: 27,
                    width: 27,
                    decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 20, 82, 181),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    child: Image(
                      image: AssetImage('assets/images/cros.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              job.description ?? 'No Description',
              style: const TextStyle(
                fontSize: 16.0,
                // color: CupertinoColors.systemGrey3,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(CupertinoIcons.location,
                    size: 16.0, color: CupertinoColors.systemGrey2),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'Location: ${job.location ?? 'Not Specified'}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      // color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(CupertinoIcons.briefcase,
                    size: 16.0, color: CupertinoColors.systemGrey2),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'Job Type: ${job.jobType ?? 'Not Specified'}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      // color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(CupertinoIcons.calendar,
                    size: 16.0, color: CupertinoColors.systemGrey2),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'Experience: ${job.minExperience ?? 'N/A'} - ${job.maxExperience ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      // color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            if (job.skills != null && job.skills!.isNotEmpty)
              SkillsSectionID(skills: job.skills!),
            const SizedBox(height: 16.0),
            if (job.jobReferralUrl != null && job.jobReferralUrl!.isNotEmpty)
              CustomButton2(
                width: double.infinity,
                text: 'Apply Now',
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white,
                ),
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(job.jobReferralUrl!))) {
                    print("Invalid URL");
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}

class SkillsSectionID extends StatelessWidget {
  final List<Skills> skills;

  const SkillsSectionID({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills Required:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            // color: CupertinoColors.white,
          ),
        ),
        const SizedBox(height: 8.0),
        ...skills.map((skill) {
          return Text(
            '${skill.skillName ?? 'No Skill Name'} - ${skill.years ?? 'N/A'} years (${skill.level ?? 'N/A'} level)',
            style: const TextStyle(
              fontSize: 14.0,
              // color: CupertinoColors.systemGrey2,
            ),
          );
        }),
      ],
    );
  }
}
