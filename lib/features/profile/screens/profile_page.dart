import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

import '../../home/controllers/home_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool dataLoaded = false;
  final getStorage = GetIt.instance<GetStorage>();
  @override
  void initState() {
    fetchProfileData();
    super.initState();
  }

  fetchProfileData() async {
    setState(() {
      dataLoaded = true;
    });
    final result = await Provider.of<AuthController>(context, listen: false)
        .fetchProfile();
    result.fold(
      (error) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Profile Data'),
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
    // Fetch email from GetStorage
    final email = getStorage.read<String>('email') ?? 'No email available';
    final name = getStorage.read<String>('name') ?? 'No name available';
    final number = getStorage.read<String>('number') ?? 'No name available';

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Profile'),
        backgroundColor: CupertinoColors.systemGrey6,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              CupertinoFormSection(
                header: const Text('Account Information'),
                children: [
                  CupertinoFormRow(
                    prefix: const Text('Email'),
                    child: Text(email),
                  ),
                  CupertinoFormRow(
                    prefix: const Text('Name'),
                    child: Text(name),
                  ),
                  CupertinoFormRow(
                    prefix: const Text('Number'),
                    child: Text(number),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: CupertinoButton(
                  color: CupertinoColors.destructiveRed,
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  onPressed: () async {
                    await getStorage.erase();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
