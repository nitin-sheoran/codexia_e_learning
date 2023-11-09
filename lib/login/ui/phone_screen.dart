import 'package:codexia_e_learning/login/ui/otp_screen.dart';
import 'package:codexia_e_learning/shared/colors_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  static String verify = '';

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController countryController = TextEditingController();

  var phone = '';

  @override
  void initState() {
    countryController.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'SKIP',
                          style: TextStyle(color: ColorsConst.redColor),
                        )),
                  ],
                ),
                const SizedBox(height: 20,),
                Image.asset(
                  'assets/images/img_1.png',
                  height: 200,
                ),
                const SizedBox(
                  height: 46,
                ),
                const Text(
                  'Phone Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'We need to register your phone before getting start !',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '|',
                        style: TextStyle(fontSize: 34),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryController.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          PhoneScreen.verify = verificationId;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OtpScreen(),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text(
                      'Send the code',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
