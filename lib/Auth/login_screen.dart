
import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Auth/verify_otp.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _fetchPhoneNumber();
  }

  Future<void> _fetchPhoneNumber() async {
    try {
      String? phoneNumber = await SmsAutoFill().hint;
      if (phoneNumber != null) {
        if (phoneNumber.startsWith('+91')) {
          phoneNumber = phoneNumber.substring(3).trim();
        }
        _phoneController.text = phoneNumber;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching phone number: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: -screenHeight*0.05,
            child: Image.asset(
              AppImages.loginEllipse, // Replace with your logo asset path
              width: MediaQuery.of(context).size.width*0.6,
              height: MediaQuery.of(context).size.height*0.29,
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.1),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight*0.3,),
                      // Phone input field with underline only for country code and text
                      TextFormField(
                        cursorColor: AppColors.primaryColor,
                        cursorWidth: 2,
                        maxLength: 10,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 3.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Text('🇮🇳', style: TextStyle(fontSize: 24)),
                                SizedBox(width: 10),
                                Text(
                                  '+91',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter number',
                          hintStyle: const TextStyle(color: Colors.black26),
                          fillColor: AppColors.greyColor.withOpacity(1.0),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your number';
                          } else if (value.length != 10) {
                            return 'Please enter a valid 10-digit number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Get account updates on ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                          Image.asset(AppImages.whatsapp),
                          const Text(" WhatsApp",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),

                        ],
                      ),
                      SizedBox(height: screenHeight*0.18),

                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              if (kDebugMode) {
                                print('Phone Number: ${_phoneController.text}');
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Logging in...')),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VerifyOtpScreen(phoneNumber: _phoneController.text.toString())),
                              ); }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            minimumSize: const Size(230, 30),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            'Login In / Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
