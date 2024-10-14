import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../AppsColor/appColor.dart';
import '../TermsAndConditions/TermsAcceptanceScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpScreen({super.key, required this.phoneNumber});

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> with CodeAutoFill {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  Timer? _timer;
  int _countdown = 30;
  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    listenForCode(); // Start listening for automatic OTP
  }

  @override
  void dispose() {
    otpController.dispose();
    errorController?.close();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _countdown = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          isButtonDisabled = false;
          timer.cancel();
        }
      });
    });
  }

  void resendOtp() {
    setState(() {
      isButtonDisabled = true;
      startTimer();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP Resent')));
  }

  void verifyOtp() {
    if (currentText.length != 4) {
      errorController!.add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() => hasError = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP Verified')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TermsAcceptanceScreen()),
      );
    }
  }

  @override
  void codeUpdated() {
    setState(() {
      currentText = code ?? ""; // Get the code from the mixin
      otpController.text = currentText;
    });
    verifyOtp(); // Automatically verify OTP
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2),
                const Text(
                  "Enter OTP",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
                ),
                const SizedBox(height: 0),
                Text(
                  "OTP sent to ${widget.phoneNumber}",
                  style: const TextStyle(fontSize: 16, color: AppColors.greyColor,fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 25),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  cursorColor: Colors.white,
                  textStyle: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    fieldHeight: 35,
                    fieldWidth: 35,
                    fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 15),
                    activeColor: AppColors.primaryColor,
                    selectedColor: AppColors.primaryColor,
                    activeFillColor: AppColors.primaryColor,
                    selectedFillColor: AppColors.primaryColor,
                    inactiveColor: AppColors.greyColor,
                    inactiveFillColor: AppColors.greyColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: otpController,
                  onCompleted: (value) {
                    setState(() {
                      currentText = value;
                      verifyOtp(); // Verify OTP automatically when entered
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                      hasError = false;
                    });
                  },
                  beforeTextPaste: (text) {
                    return false;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.watch_later_outlined, color: Colors.black,size: 16,),
                    TextButton(
                      onPressed: isButtonDisabled ? null : resendOtp,
                      child: Text(
                        'Resend OTP in',
                        style: TextStyle(color: isButtonDisabled ? Colors.grey : AppColors.primaryColor,fontSize: 12),
                      ),
                    ),
                    Text(
                      " $_countdown s",
                      style: const TextStyle(color: AppColors.greyColor),
                    ),


                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                     verifyOtp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding for button height
                      minimumSize: const Size(230, 30), // Adjust the width and height
                      shape: const StadiumBorder(), // Creates the circular shape (pill shape)
                    ),
                    child: const Text(
                      'Verify OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


