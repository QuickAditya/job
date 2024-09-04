import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/home/controllers/home_controller.dart';
import 'package:job/utils/custombutton.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool dataLoaded = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchHomePageData();
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // setState(() {
      //   message = "reach the bottom";
      // });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      // setState(() {
      //   message = "reach the top";
      // });
    }
  }

  fetchHomePageData() async {
    setState(() {
      dataLoaded = true;
    });
    final result = await Provider.of<HomeController>(context, listen: false)
        .fetchJobData();
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
        setState(() {
          dataLoaded = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // fetchHomePageData();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Job Listings'),
        leading: IconButton(
            onPressed: () {
              //  Navigator.pushNamed(context, '/SavedJobsbyID');
              Navigator.pushNamed(context, '/savingjob');
            },
            icon: Icon(
              CupertinoIcons.bookmark,
              size: 20,
            )),
        trailing: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const Icon(CupertinoIcons.profile_circled)),
      ),
      child: Consumer<HomeController>(
        builder: (_, homeController, __) {
          if (homeController.jobModel == null ||
              homeController.jobModel!.data == null ||
              homeController.jobModel!.data!.job == null ||
              !dataLoaded) {
            return const Center(child: CupertinoActivityIndicator());
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
                  onRefresh: () async {
                    await fetchHomePageData();
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
                              fetchHomePageData();
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
                            fetchHomePageData();
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
    final homeController = Provider.of<HomeController>(context, listen: false);
    final getStorage = GetIt.instance<GetStorage>();

    // Fetch the saved job IDs from GetStorage
    dynamic savedJobData = getStorage.read('savejob');
    List<String> savedJobIds = [];

    if (savedJobData is String) {
      savedJobIds = [savedJobData];
    } else if (savedJobData is List) {
      savedJobIds = List<String>.from(savedJobData);
    }

    bool isSaved = savedJobIds.contains(job.jobId.toString());

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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (job.jobId != null) {
                          log('save job');

                          if (!isSaved) {
                            savedJobIds.add(job.jobId.toString());
                            getStorage.write('savejob', savedJobIds);
                          }

                          log('stored job IDs: ' + savedJobIds.toString());
                          log('stored job IDs length: ' +
                              savedJobIds.length.toString());

                          // Force a rebuild to update the UI
                          (context as Element).markNeedsBuild();
                        }
                      },
                      child: Container(
                          // padding: const EdgeInsets.all(5),
                          height: 30,
                          width: 30,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(255, 20, 82, 181),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: isSaved
                              ?
                              //  Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: const Image(
                              //       image: AssetImage('assets/images/save.png'),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   )
                              const Icon(
                                  CupertinoIcons.bookmark_fill,
                                  color: CupertinoColors.white,
                                )
                              : const Icon(
                                  CupertinoIcons.bookmark,
                                  color: CupertinoColors.white,
                                )),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        height: 27,
                        width: 27,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 20, 82, 181),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Image(
                          image: AssetImage('assets/images/share.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              job.description ?? 'No Description',
              style: const TextStyle(
                fontSize: 16.0,
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
                textStyle: const TextStyle(
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
