import 'package:codexia_e_learning/login/service/auth_firebase_services.dart';
import 'package:codexia_e_learning/login/ui/auth_login_screen.dart';
import 'package:codexia_e_learning/shared/app_const.dart';
import 'package:codexia_e_learning/shared/colors_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime _date = DateTime.now();

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('WELCOME'),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text(
                'Calendar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: _handleDatePicker,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text(
                'Share',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Share.share(AppConst.shareUrlText);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                await AuthFirebaseService().logOut();
                Fluttertoast.showToast(msg: 'Account Logout');
                if (mounted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthLoginScreen()));
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Your Profile',
          style: TextStyle(color: ColorsConst.whiteColor),
        ),
        iconTheme: const IconThemeData(color: ColorsConst.whiteColor),
        backgroundColor: ColorsConst.blueColor,
      ),
      body: Center(
        child: Column(
          children: [
            Text(FirebaseAuth.instance.currentUser?.displayName ?? ''),
          ],
        ),
      ),
    );
  }
}
