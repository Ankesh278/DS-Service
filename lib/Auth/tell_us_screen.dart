
import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:ds_service/TermsAndConditions/TermsAcceptanceScreen.dart';
import 'package:flutter/material.dart';

class TellUsScreen extends StatefulWidget {
  const TellUsScreen({super.key});

  @override
  _TellUsScreenState createState() => _TellUsScreenState();
}

class _TellUsScreenState extends State<TellUsScreen> {
  final _formKey = GlobalKey<FormState>();
 final  TextEditingController nameController=TextEditingController();
  String? workList;
  String? workCityList;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AppImages.ellipseRight)),
          Positioned(
              top: screenHeight*0.07,
              left: screenWidth*0.02,
              child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios))),
          Positioned(
              top: screenHeight*0.15,
              left: screenWidth*0.15,
              child: const Text("Tell us about yourself!",style: TextStyle(color: AppColors.primaryColor,fontSize: 18,fontWeight: FontWeight.w800),)),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight*0.6,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          Container(
                            height: screenHeight * 0.10,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: "What's your full name?",
                                      labelStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      hintText: 'Enter name',
                                      hintStyle: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Add error message spacing
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),


                          SizedBox(height: screenHeight * 0.05),

                          Stack(
                            clipBehavior: Clip.none,
                            children: [

                              Container(
                                height: screenHeight * 0.06,
                                padding: const EdgeInsets.only(left: 10),
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: PopupMenuButton<String>(
                                  onSelected: (String value) {
                                    setState(() {
                                      workList = value;
                                    });
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return works.map<PopupMenuEntry<String>>((String value) {
                                      return PopupMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                  offset: const Offset(0, 50),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          workList ?? 'Select work',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
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
                              // Positioned Label
                              Positioned(
                                left: 25,
                                top: -10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  color: AppColors.primaryColor,
                                  child: const Text(
                                    "What's your profession?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),


                          SizedBox(height: screenHeight * 0.05),


                          Stack(
                            clipBehavior: Clip.none,
                            children: [

                              Container(
                                height: screenHeight * 0.06,
                                padding: const EdgeInsets.only(left: 10),
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: PopupMenuButton<String>(
                                  onSelected: (String value) {
                                    setState(() {
                                      workCityList = value;
                                    });
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return cities.map<PopupMenuEntry<String>>((String value) {
                                      return PopupMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                  offset: const Offset(0, 50),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          workCityList ?? 'Select city',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
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
                              // Positioned Label
                              Positioned(
                                left: 25,
                                top: -10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  color: AppColors.primaryColor,
                                  child: const Text(
                                    "What's your home located?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                    scale: 1,
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 2, // Border width
                                      ),
                                      activeColor: Colors.white,
                                      focusColor: Colors.white,
                                      autofocus: true,
                                      checkColor: AppColors.primaryColor,
                                      value: isTermsAccepted,
                                      onChanged: (value) {
                                        setState(() {
                                          isTermsAccepted = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "By continuing, you accept NEED TO ASSIST company's",
                                          style: TextStyle(fontSize: 8, color: Colors.white),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Terms & Privacy Policy, ensuring secure collaboration',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.02),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(
                              child: SizedBox(
                                width: double.infinity,
                                height: screenHeight * 0.05,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        isTermsAccepted &&
                                        workList != null &&
                                        workCityList != null) {

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => const TermsAcceptanceScreen()),
                                            (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showMaterialBanner(
                                         MaterialBanner(

                                           actions: [
                                             TextButton(
                                               onPressed: () {
                                                 ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                               },
                                               child: const Text(
                                                 "DISMISS",
                                                 style: TextStyle(color: Colors.red),
                                               ),
                                             ),
                                           ],
                                          backgroundColor: Colors.white,
                                          content: const Text(
                                              'Please fill in all fields and accept terms',style: TextStyle(color: Colors.red),),
                                        ),

                                      );

                                      Future.delayed(const Duration(seconds: 3), () {
                                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('Continue',style: TextStyle(color: AppColors.primaryColor),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))

        ],
      ),
    );
  }
}
