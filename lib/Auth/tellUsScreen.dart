import 'package:ds_service/AppsColor/appColor.dart';
import 'package:flutter/material.dart';

class Tellusscreen extends StatefulWidget {
  const Tellusscreen({super.key});

  @override
  _TellusscreenState createState() => _TellusscreenState();
}

class _TellusscreenState extends State<Tellusscreen> {
  final _formKey = GlobalKey<FormState>();
  String? workList;
  String? workcityList;

  List<String> works = [
    'Hr',
    'Manager',
    'Team Leader',
    'Intern',
  ];
  bool isTermsAccepted = false;

  List<String> cities = [
    'Mumbai',
    'Noida',
    'Delhi',
    'Gurgaon',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    'Tell us about yourself',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),

                // Name TextFormField (centered)
                Container(
                  height: screenHeight * 0.07,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "What's your name?",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      hintText: 'Enter name',
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 12),
                      filled: true,
                      fillColor: Colors.white30,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),

                // First DropdownButtonFormField
                Container(
                  height: screenHeight * 0.07,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: AppColors.primaryColor, width: 1),
                  ),
                  child: PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {
                        workList = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return works
                          .map<PopupMenuEntry<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(top: 10),
                            width: screenWidth * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }).toList();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    offset: const Offset(0, 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            workList ?? 'Select work',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                              topRight: Radius.circular(2),
                              bottomRight: Radius.circular(2),
                            ),
                          ),
                          width: screenWidth * 0.15,
                          height: double.infinity,
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),

                // Second DropdownButtonFormField
                Container(
                  height: screenHeight * 0.07,
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: AppColors.primaryColor, width: 1),
                  ),
                  child: PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {
                        workcityList = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return cities
                          .map<PopupMenuEntry<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(top: 10),
                            width: screenWidth * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }).toList();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    offset: const Offset(0, 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            workcityList ?? 'Select city',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                              topRight: Radius.circular(2),
                              bottomRight: Radius.circular(2),
                            ),
                          ),
                          width: screenWidth * 0.15,
                          height: double.infinity,
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Terms and Conditions with Checkbox
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: isTermsAccepted,
                          onChanged: (value) {
                            setState(() {
                              isTermsAccepted = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "By proceeding, you agree to Urban Company's",
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Terms & conditions and privacy policy',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.08),

                // Continue Button
                Center(
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            isTermsAccepted &&
                            workList != null &&
                            workcityList != null) {
                          // Process the form
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please fill in all fields and accept terms'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Continue',style: TextStyle(color: Colors.white),),
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
