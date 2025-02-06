import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Auth/verify_otp.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen> {
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
      if (phoneNumber != null && phoneNumber.startsWith('+91')) {
        _phoneController.text = phoneNumber.substring(3).trim();
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
            top: -screenHeight * 0.05,
            child: Image.asset(
              AppImages.loginEllipse,
              width: screenWidth * 0.6,
              height: screenHeight * 0.29,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.3),
                      _buildPhoneInputField(),
                       SizedBox(height: screenHeight*0.02),
                      _buildWhatsappInfo(),
                      SizedBox(height: screenHeight * 0.18),
                      _buildLoginButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Phone Input Field
  Widget _buildPhoneInputField() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: _phoneController,
      cursorColor: AppColors.primaryColor,
      cursorWidth: 2,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon:  Padding(
          padding: EdgeInsets.only(left: screenWidth*0.05, right: screenWidth*0.01),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🇮🇳', style: TextStyle(fontSize: 24)),
              SizedBox(width: screenWidth*0.02),
              const Text(
                '+91',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
        hintText: 'Enter number',
        hintStyle: const TextStyle(color: Colors.black26),
        fillColor: AppColors.greyColor.withValues(alpha: 0.8),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth*0.1),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth*0.1),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth*0.1),
          borderSide: BorderSide.none,
        ),
        contentPadding:  EdgeInsets.symmetric(vertical: screenHeight*0.018, horizontal: screenWidth*0.05),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your number';
        } else if (value.length != 10) {
          return 'Please enter a valid 10-digit number';
        }
        return null;
      },
    );
  }
  Widget _buildWhatsappInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Get account updates on ",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        Image.asset(AppImages.whatsapp),
        const Text(
          " WhatsApp",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
  // Login Button
  Widget _buildLoginButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (_formKey.currentState?.validate() == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging in...')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyOtpScreen(phoneNumber: _phoneController.text),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding:  EdgeInsets.symmetric(vertical: screenHeight*0.013),
          minimumSize:  Size(screenWidth*0.6, screenHeight*0.02),
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
    );
  }
}
