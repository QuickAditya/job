import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/home/controllers/home_controller.dart';
import 'package:job/features/home/models/job_model.dart';
// import 'package:job/features/home/models/jobbybobId.dart' as jobidmodel;

import 'package:job/features/home/screens/home_screen.dart';
import 'package:job/utils/custombutton.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SavedJobsbyID extends StatefulWidget {
  const SavedJobsbyID({super.key});

  @override
  State<SavedJobsbyID> createState() => _SavedJobsbyIDState();
}

class _SavedJobsbyIDState extends State<SavedJobsbyID> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Consumer<HomeController>(
        builder: (_, hocontroller, __) {
          final getStorage = GetIt.instance<GetStorage>();
          List savedjobs = getStorage.read('savejob');
          log(">>>>>>>>>>ll" + savedjobs.toString());
          return SafeArea(
              child: ListView.builder(
            itemCount: savedjobs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future:
                    hocontroller.jobcardbyJobid(int.parse(savedjobs[index])),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoApp(
                      home: CupertinoActivityIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const CupertinoApp(
                      home: Center(
                        child: Text('Error initializing storage'),
                      ),
                    );
                  } else {
                    final jobc = snapshot.data!;
                    log(">>>>>>>>>>lllllllllll" + jobc.toString());

                    return FavJobCard(
                      job: jobc,
                    );
                  }
                },
              );
            },
          ));
        },
      ),
    );
  }
}

class FavJobCard extends StatelessWidget {
  final Job job;

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
                Text(
                  job.jobTitle ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    // color:
                    //     isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // homeController.removeJob(job);
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
              SkillsSection(skills: job.skills!),
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
