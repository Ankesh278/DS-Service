import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Auth/VerifyOtp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Company Logo
              Image.asset(
                'assets/images/loginLogo.png', // Replace with your logo asset path
                width: MediaQuery.of(context).size.width*0.7,
                height: MediaQuery.of(context).size.height*0.3,
              ),
              const SizedBox(height: 20),
        
              // Form and phone input
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phone input field with underline only for country code and text
                    TextFormField(
                      cursorColor: AppColors.primaryColor,
                      cursorWidth: 2,
                      maxLength: 10,
                      cursorHeight: 15,
                      controller: _phoneController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10)
                      ],
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // India flag emoji and country code
                              Text('🇮🇳', style: TextStyle(fontSize: 24)),
                              SizedBox(width: 10),
                              Text(
                                '+91',
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        hintText: ' Enter number',
                        hintStyle: TextStyle(color: AppColors.greyColor),
                        // Underline only for the country code and the phone number input
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please number';
                        } else if (value.length != 10) {
                          return 'Please enter valid 10-digit number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5,),
                    const Row(
                      children: [
                       Text("Get account updates on ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                         ImageIcon(
                          AssetImage('assets/images/WhatsApp.png'), // Path to your image
                          size: 20,  // Adjust size as needed
                          color: Colors.black,  // Optionally change the color
                        ),
                        Text(" WhatsApp",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),

                      ],
                    ),
                    const SizedBox(height: 40),
        
                    // Login button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            // Handle login process
                              print('Phone Number: ${_phoneController.text}');
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
                          padding: const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding for button height
                          minimumSize: const Size(230, 30), // Adjust the width and height
                          shape: const StadiumBorder(), // Creates the circular shape (pill shape)
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
