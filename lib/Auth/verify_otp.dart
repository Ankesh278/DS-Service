import 'dart:async';
import 'package:ds_service/Auth/tell_us_screen.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../AppsColor/appColor.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpScreen({super.key, required this.phoneNumber});

  @override
  VerifyOtpScreenState createState() => VerifyOtpScreenState();
}

class VerifyOtpScreenState extends State<VerifyOtpScreen> with CodeAutoFill {
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    listenForCode();
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
      errorController!.add(ErrorAnimationType.shake);
      setState(() => hasError = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP Verified')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TellUsScreen()),
      );
    }
  }

  @override
  void codeUpdated() {
    setState(() {
      currentText = code ?? "";
      otpController.text = currentText;
    });
    verifyOtp();
  }

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 10) {
      return phoneNumber;
    }
    return phoneNumber.replaceRange(2, phoneNumber.length - 4, '******');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppImages.rectangleVerify,
              fit: BoxFit.cover,
              height: screenHeight * 0.23,
            ),
          ),

          // Back button and Header
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Confirm OTP", style: TextStyle(fontSize: 16, color: AppColors.greyColor, fontWeight: FontWeight.w600)),
                      Text("OTP has been sent to ${maskPhoneNumber(widget.phoneNumber)}", style: const TextStyle(fontSize: 12, color: AppColors.greyColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main content (OTP input)
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.4),

                    // PinCode TextField for OTP input
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      cursorColor: Colors.white,
                      textStyle: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 8),
                        activeColor: AppColors.primaryColor,
                        selectedColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        activeFillColor: AppColors.primaryColor,
                        selectedFillColor: AppColors.primaryColor,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: otpController,
                      onCompleted: (value) {
                        setState(() {
                          currentText = value;
                          verifyOtp();
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                          hasError = false;
                        });
                      },
                    ),

                    // Timer and Resend OTP Button
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.watch_later_outlined, color: Colors.black, size: 16),
                        TextButton(
                          onPressed: isButtonDisabled ? null : resendOtp,
                          child: Text(
                            'Resend OTP in',
                            style: TextStyle(color: isButtonDisabled ? Colors.grey : AppColors.primaryColor, fontSize: 12),
                          ),
                        ),
                        Text(" $_countdown s", style: const TextStyle(color: AppColors.greyColor)),
                      ],
                    ),

                    // Verify OTP Button
                    SizedBox(height: screenHeight * 0.1),
                    ElevatedButton(
                      onPressed: verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(230, 30),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Verify OTP', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
