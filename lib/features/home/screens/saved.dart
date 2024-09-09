// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get_it/get_it.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:job/features/home/controllers/home_controller.dart';
// import 'package:job/features/home/models/job_model.dart';
// import 'package:job/features/home/screens/home_screen.dart';
// import 'package:job/utils/custombutton.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SavedJobs extends StatefulWidget {
//   const SavedJobs({super.key});

//   @override
//   State<SavedJobs> createState() => _SavedJobsState();
// }

// class _SavedJobsState extends State<SavedJobs> {
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     // _scrollController.addListener(_scrollListener);
//     // fetchHomePageData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final getStorage = GetIt.instance<GetStorage>();
//     List savedjobs = getStorage.read('savejob');
//     log(">>>>>>>>>>" + savedjobs.toString());
//     List<Job> matchedjob = [];

//     context.read<HomeController>().JobList.forEach((job) {
//       if (savedjobs.contains(job.jobId)) {
//         matchedjob.add(job);
//         log("Matched job: $job");
//       }
//     });

//     return CupertinoPageScaffold(child: SafeArea(
//       child: Consumer<HomeController>(
//         builder: (context, hcontroller, child) {
//           log('$matchedjob');
//           return Padding(
//             padding: EdgeInsets.zero,
//             // padding: EdgeInsets.only(
//             //     top: Platform.isIOS ? 100.0 : 70.0, bottom: 50.0),
//             child: CustomScrollView(
//               controller: _scrollController,
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: Text(
//                       'Saved jobs',
//                       style: TextStyle(
//                           color: Color.fromARGB(155, 20, 82, 181),
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 // SliverList(
//                 //   delegate: SliverChildBuilderDelegate((context, index) {
//                 //     final savejobs = hcontroller.saveJobList[index];
//                 //     log('Job: ${savejobs.jobTitle}');
//                 //     return hcontroller.saveJobList == null ||
//                 //             hcontroller.saveJobList.isEmpty
//                 //         ? SizedBox(
//                 //             child: Center(child: Text('No saved jobs')),
//                 //           )
//                 //         : SaveJobCard(job: savejobs);
//                 //   }, childCount: hcontroller.saveJobList.length),
//                 // ),

// //                 SliverList(
// //   delegate: SliverChildBuilderDelegate(
// //     (context, index) {
// //       // Retrieve the stored job IDs as a List<String>
// //       List<String> savedJobIds = List<String>.from(
// //           getStorage.read<List<dynamic>>('savejob') ?? []);

// //       // Get the list of jobs
// //       final jobs = hcontroller.jobModel!.data!.job!;

// //       // Filter the jobs to include only those whose ID is in savedJobIds
// //       final filteredJobs = jobs
// //           .where((job) => savedJobIds.contains(job.jobId.toString()))
// //           .toList();

// //       // Return the job card if there are any filtered jobs
// //       if (index < filteredJobs.length) {
// //         final job = filteredJobs[index];
// //         return JobCard(job: job);
// //       } else {
// //         return SizedBox.shrink(); // Return an empty widget if no jobs match
// //       }
// //     },
// //     childCount: hcontroller.jobModel!.data!.job!
// //         .where((job) => List<String>.from(
// //                 getStorage.read<List<dynamic>>('savejob') ?? [])
// //             .contains(job.jobId.toString()))
// //         .length, // The count of filtered jobs
// //   ),
// // )

//                 // SliverList.builder(
//                 //   itemCount: ,
//                 //   itemBuilder: (context, index) {

//                 //   },
//                 //   delegate: SliverChildBuilderDelegate((context, index) {
//                 //     // final savejobs = hcontroller.saveJobList[index];

//                 //     // hcontroller.JobList.where(
//                 //     //   (Job) {
//                 //     //     if (savedjobs.contains(Job.jobId)) {
//                 //     //       matchedjob = Job;
//                 //     //       return true;
//                 //     //     } else {
//                 //     //       return false;
//                 //     //     }
//                 //     //   },
//                 //     // );
//                 //     // log("?????????????????" + matchedjob.toString());
//                 //     // log('Job: ${savejobs.jobTitle}');
//                 // return hcontroller.saveJobList == null ||
//                 //         hcontroller.saveJobList.isEmpty
//                 //     ? SizedBox(
//                 //         child: Center(child: Text('No saved jobs')),
//                 //       )
//                 //     : SaveJobCard(job: matchedjob);
//                 //   }, childCount: hcontroller.saveJobList.length),
//                 // ),

//                 SliverList.builder(
//                   itemBuilder: (context, index) {
//                     return matchedjob.isEmpty
//                         ? SizedBox(
//                             child: Center(child: Text('No saved jobs')),
//                           )
//                         : SaveJobCard(job: matchedjob[index]);
//                   },
//                   itemCount: matchedjob!.length,
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     ));
//   }
// }

// class SaveJobCard extends StatelessWidget {
//   final Job job;

//   const SaveJobCard({super.key, required this.job});

//   @override
//   Widget build(BuildContext context) {
//     var brightness = MediaQuery.of(context).platformBrightness;
//     bool isDarkMode = brightness == Brightness.dark;
//     final homeController = Provider.of<HomeController>(context, listen: false);
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//       decoration: BoxDecoration(
//         color: isDarkMode
//             ? CupertinoColors.darkBackgroundGray
//             : CupertinoColors.white,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: [
//           BoxShadow(
//             color: CupertinoColors.black.withOpacity(0.1),
//             offset: const Offset(0, 4),
//             blurRadius: 8.0,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   job.jobTitle ?? 'No Title',
//                   style: const TextStyle(
//                     fontSize: 22.0,
//                     fontWeight: FontWeight.bold,
//                     // color:
//                     //     isDarkMode ? CupertinoColors.white : CupertinoColors.black,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     homeController.removeJob(job);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(6),
//                     height: 27,
//                     width: 27,
//                     decoration: ShapeDecoration(
//                         color: Color.fromARGB(255, 20, 82, 181),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24))),
//                     child: Image(
//                       image: AssetImage('assets/images/cros.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               job.description ?? 'No Description',
//               style: const TextStyle(
//                 fontSize: 16.0,
//                 // color: CupertinoColors.systemGrey3,
//               ),
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 12.0),
//             Row(
//               children: [
//                 const Icon(CupertinoIcons.location,
//                     size: 16.0, color: CupertinoColors.systemGrey2),
//                 const SizedBox(width: 4.0),
//                 Expanded(
//                   child: Text(
//                     'Location: ${job.location ?? 'Not Specified'}',
//                     style: const TextStyle(
//                       fontSize: 14.0,
//                       // color: CupertinoColors.systemGrey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8.0),
//             Row(
//               children: [
//                 const Icon(CupertinoIcons.briefcase,
//                     size: 16.0, color: CupertinoColors.systemGrey2),
//                 const SizedBox(width: 4.0),
//                 Expanded(
//                   child: Text(
//                     'Job Type: ${job.jobType ?? 'Not Specified'}',
//                     style: const TextStyle(
//                       fontSize: 14.0,
//                       // color: CupertinoColors.systemGrey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8.0),
//             Row(
//               children: [
//                 const Icon(CupertinoIcons.calendar,
//                     size: 16.0, color: CupertinoColors.systemGrey2),
//                 const SizedBox(width: 4.0),
//                 Expanded(
//                   child: Text(
//                     'Experience: ${job.minExperience ?? 'N/A'} - ${job.maxExperience ?? 'N/A'}',
//                     style: const TextStyle(
//                       fontSize: 14.0,
//                       // color: CupertinoColors.systemGrey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16.0),
//             if (job.skills != null && job.skills!.isNotEmpty)
//               SkillsSection(skills: job.skills!),
//             const SizedBox(height: 16.0),
//             if (job.jobReferralUrl != null && job.jobReferralUrl!.isNotEmpty)
//               CustomButton2(
//                 width: double.infinity,
//                 text: 'Apply Now',
//                 textStyle: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: CupertinoColors.white,
//                 ),
//                 onPressed: () async {
//                   if (!await launchUrl(Uri.parse(job.jobReferralUrl!))) {
//                     print("Invalid URL");
//                   }
//                 },
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }
