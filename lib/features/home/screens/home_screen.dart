import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:job/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job_model.dart';

// Testing
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool dataLoaded = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);

    // fetchHomePageData();
    super.initState();
  }

  // _scrollListener() {
  //   if (_scrollController.offset >=
  //           _scrollController.position.maxScrollExtent &&
  //       !_scrollController.position.outOfRange) {
  //     // setState(() {
  //     //   message = "reach the bottom";
  //     // });
  //   }
  //   if (_scrollController.offset <=
  //           _scrollController.position.minScrollExtent &&
  //       !_scrollController.position.outOfRange) {
  //     // setState(() {
  //     //   message = "reach the top";
  //     // });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Job Listings'),
        trailing: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/profile'),
          icon: const Icon(
            key: Key('profile-circle'),
            CupertinoIcons.profile_circled,
          ),
        ),
      ),
      child: Consumer<HomeController>(
        builder: (_, homeController, __) {
          if (homeController.isLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (homeController.jobModel == null ||
              homeController.jobModel!.data == null ||
              homeController.jobModel!.data!.job == null ||
              homeController.jobModel!.data!.job!.isEmpty) {
            return const Center(child: Text('No Jobs Found'));
          }

          return Padding(
            padding: EdgeInsets.only(
                top: Platform.isIOS ? 100.0 : 70.0, bottom: 50.0),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //         bottom: 20.0, left: 16.0, top: 16.0),
                //     child: Text(
                //       'Page ${homeController.currentPage} / Total Items ${homeController.pageLength}',
                //       style: const TextStyle(
                //         fontSize: 22.0,
                //         fontWeight: FontWeight.bold,
                //         // color:
                //         //     isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                //       ),
                //     ),
                //   ),
                // ),
                CupertinoSliverRefreshControl(
                  key: Key('refresh-indicator'),
                  onRefresh: () async {
                    await homeController.fetchHomePageData(context);
                  },
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final job = homeController.jobModel!.data!.job![index];
                      return JobCard(job: job);
                    },
                    childCount: homeController.jobModel!.data!.job!.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (homeController.currentPage > 1)
                          CupertinoButton(
                            child: const Text("Previous"),
                            onPressed: () {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                _scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              });

                              homeController.updateCurrentPage(
                                  homeController.currentPage - 1);
                              homeController.fetchHomePageData(context);
                            },
                          ),
                        if (homeController.currentPage > 1)
                          const SizedBox(width: 10),
                        Text("${homeController.currentPage}"),
                        const SizedBox(width: 10),
                        CupertinoButton(
                          child: const Text("Next"),
                          onPressed: () {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            });

                            homeController.updateCurrentPage(
                                homeController.currentPage + 1);
                            homeController.fetchHomePageData(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
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
            Text(
              job.jobTitle ?? 'No Title',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                // color:
                //     isDarkMode ? CupertinoColors.white : CupertinoColors.black,
              ),
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
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(job.jobReferralUrl!))) {
                      print("Invalid URL");
                    }
                  },
                  child: const Text(
                    'Apply Now',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  final List<Skills> skills;

  const SkillsSection({super.key, required this.skills});

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
