import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job/features/home/repos/home_repo.dart';
import 'package:job/features/home/screens/home_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:job/features/home/controllers/home_controller.dart';
import 'package:job/features/home/models/job_model.dart';

import 'home_screen_test.mocks.dart';

// class MockHomeController extends Mock implements HomeController {}

// class MockHomeRepo extends Mock implements HomeRepo {}

@GenerateMocks([HomeRepo, HomeController])
void main() {
  // MockHomeRepo mockHomeRepo;
  late HomeController mockHomeController;

  setUp(() {
    // mockHomeRepo = MockHomeRepo();
    mockHomeController = MockHomeController();
    // homeController.homeRepo = mockHomeRepo; // Use the mock in the controller
  });

  Widget createHomePageWidget() {
    return ChangeNotifierProvider<HomeController>.value(
      value: mockHomeController,
      child: const CupertinoApp(
        home: HomePage(),
      ),
    );
  }

  testWidgets('Check HomePage Loading', (WidgetTester tester) async {
    // Arrange
    when(mockHomeController.jobModel).thenReturn(null);
    when(mockHomeController.isLoading).thenReturn(true);
    when(mockHomeController.currentPage).thenReturn(1);
    when(mockHomeController.pageLength).thenReturn(5);

    // Act
    await tester.pumpWidget(createHomePageWidget());

    // Assert
    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });

  testWidgets('No Jobs Found', (WidgetTester tester) async {
    // Arrange
    when(mockHomeController.jobModel).thenReturn(null);
    when(mockHomeController.isLoading).thenReturn(false);

    when(mockHomeController.currentPage).thenReturn(1);
    when(mockHomeController.pageLength).thenReturn(5);

    // Act
    await tester.pumpWidget(createHomePageWidget());

    // Assert
    expect(find.text('No Jobs Found'), findsOneWidget);
  });

  testWidgets('displays job cards when data is loaded',
      (WidgetTester tester) async {
    // Arrange
    final jobModel = JobModel(
      data: Data(
        job: [
          Job(
            jobTitle: 'Software Engineer',
            description: 'Develop awesome software!',
            location: 'San Francisco',
            jobType: 'Full-time',
            minExperience: '2 years',
            maxExperience: '5 years',
            skills: [
              Skills(skillName: 'Flutter', years: '2', level: 'Intermediate'),
            ],
            jobReferralUrl: 'https://example.com/apply',
          ),
        ],
      ),
    );
    when(mockHomeController.jobModel).thenReturn(jobModel);
    when(mockHomeController.isLoading).thenReturn(false);
    when(mockHomeController.currentPage).thenReturn(1);
    when(mockHomeController.pageLength).thenReturn(5);

    // Act
    await tester.pumpWidget(createHomePageWidget());

    // Assert
    expect(find.byType(JobCard), findsOneWidget);
  });

  testWidgets('refresh button works', (WidgetTester tester) async {
    // Arrange
    final jobModel = JobModel(
      data: Data(
        job: [
          Job(
            jobTitle: 'Software Engineer',
            description: 'Develop awesome software!',
            location: 'San Francisco',
            jobType: 'Full-time',
            minExperience: '2 years',
            maxExperience: '5 years',
            skills: [
              Skills(skillName: 'Flutter', years: '2', level: 'Intermediate'),
            ],
            jobReferralUrl: 'https://example.com/apply',
          ),
        ],
      ),
    );
    when(mockHomeController.jobModel).thenReturn(jobModel);
    // when(mockHomeController.jobModel).thenReturn(null);
    when(mockHomeController.isLoading).thenReturn(false);
    when(mockHomeController.currentPage).thenReturn(1);
    when(mockHomeController.pageLength).thenReturn(5);

    // Act
    await tester.pumpWidget(createHomePageWidget());
    // await tester.drag(find.byType(CupertinoSliverRefreshControl),Offset(0, 500));
    await tester.fling(find.text('Apply Now'), const Offset(0, 900), 800);
    await tester.pump();

    // Assert
    // verify(mockHomeController.fetchJobData()).called(1);
    expect(find.byType(JobCard), findsOneWidget);

  });

  group('JobModel', () {
    test('fromJson and toJson should work for JobModel', () {
      // Arrange
      final json = {
        'status': 200,
        'data': {
          'job': [
            {
              'job_id': '1',
              'job_title': 'Software Developer',
              'description': 'Develop software',
              'location': 'New York',
              'location_type': 'Remote',
              'job_type': 'Full-time',
              'min_charge': 5000,
              'max_charge': 7000,
              'min_experience': '2 years',
              'max_experience': '5 years',
              'job_referral_url': 'https://example.com',
              'skills': [
                {
                  'skill_name': 'Dart',
                  'years': '2',
                  'level': 'Intermediate',
                },
              ],
              'positions': [
                {
                  'position_name': 'Senior Developer',
                },
              ],
              'currencySymbol': '\$',
              'currency': 'USD',
            },
          ],
          'total_count': 1,
        },
        'message': 'Success',
      };

      // Act
      final jobModel = JobModel.fromJson(json);
      final jsonOutput = jobModel.toJson();

      // Assert
      expect(jsonOutput, equals(json));
    });

    test('fromJson and toJson should work for Data', () {
      // Arrange
      final json = {
        'job': [
          {
            'job_id': '1',
            'job_title': 'Software Developer',
            'description': 'Develop software',
            'location': 'New York',
            'location_type': 'Remote',
            'job_type': 'Full-time',
            'min_charge': 5000,
            'max_charge': 7000,
            'min_experience': '2 years',
            'max_experience': '5 years',
            'job_referral_url': 'https://example.com',
            'skills': [
              {
                'skill_name': 'Dart',
                'years': '2',
                'level': 'Intermediate',
              },
            ],
            'positions': [
              {
                'position_name': 'Senior Developer',
              },
            ],
            'currencySymbol': '\$',
            'currency': 'USD',
          },
        ],
        'total_count': 1,
      };

      // Act
      final data = Data.fromJson(json);
      final jsonOutput = data.toJson();

      // Assert
      expect(jsonOutput, equals(json));
    });

    test('fromJson and toJson should work for Job', () {
      // Arrange
      final json = {
        'job_id': '1',
        'job_title': 'Software Developer',
        'description': 'Develop software',
        'location': 'New York',
        'location_type': 'Remote',
        'job_type': 'Full-time',
        'min_charge': 5000,
        'max_charge': 7000,
        'min_experience': '2 years',
        'max_experience': '5 years',
        'job_referral_url': 'https://example.com',
        'skills': [
          {
            'skill_name': 'Dart',
            'years': '2',
            'level': 'Intermediate',
          },
        ],
        'positions': [
          {
            'position_name': 'Senior Developer',
          },
        ],
        'currencySymbol': '\$',
        'currency': 'USD',
      };

      // Act
      final job = Job.fromJson(json);
      final jsonOutput = job.toJson();

      // Assert
      expect(jsonOutput, equals(json));
    });

    test('fromJson and toJson should work for Skills', () {
      // Arrange
      final json = {
        'skill_name': 'Dart',
        'years': '2',
        'level': 'Intermediate',
      };

      // Act
      final skills = Skills.fromJson(json);
      final jsonOutput = skills.toJson();

      // Assert
      expect(jsonOutput, equals(json));
    });

    test('fromJson and toJson should work for Positions', () {
      // Arrange
      final json = {
        'position_name': 'Senior Developer',
      };

      // Act
      final positions = Positions.fromJson(json);
      final jsonOutput = positions.toJson();

      // Assert
      expect(jsonOutput, equals(json));
    });
  });
}
