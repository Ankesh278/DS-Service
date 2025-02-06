
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});



  @override
  ConfirmationScreenState createState() => ConfirmationScreenState();
}

class ConfirmationScreenState extends State<ConfirmationScreen> {

  String formatDate(DateTime? date) {
    if (date == null) return 'No date selected';
    final day = DateFormat('EEEE').format(date);
    final month = DateFormat('MMMM').format(date);
    final dayNumber = date.day;
    final suffix = getDaySuffix(dayNumber);
    return '$day, $month $dayNumber$suffix';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //String formattedDate=formatDate(widget.selectedDate);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: -screenHeight*0.05,
            child: Image.asset(
              AppImages.loginEllipse,
              width: MediaQuery.of(context).size.width*0.55,
              height: MediaQuery.of(context).size.height*0.34,
            ),
          ),

          Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AppImages.ellipseRight)),
          Positioned(
              left: 20,
              top: screenHeight*0.05,
              child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,))),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight*0.55,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  width: screenWidth*0.7,
                  height: screenHeight * 0.3,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.help_outline_outlined,color: Colors.white,size: 40,)),
                      const SizedBox(height: 20,),
                      const Text("Confirm leave on formattedDate",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 10,),
                      const Text("You will stop receiving any jobs for this day.",style:TextStyle(color: Colors.grey,fontSize: 12)),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context,true);
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>const PhotoVerification()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: screenWidth*0.6,
                          margin: EdgeInsets.only(left: screenWidth*0.13,top: screenWidth*0.04),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primaryColorLight
                          ),
                          child: Center(child: Text("Accept",style: TextStyle(color: Colors.white.withOpacity(0.7))
                            ,)),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context,false);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: screenWidth*0.6,
                          margin: EdgeInsets.only(left: screenWidth*0.13,top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white
                          ),
                          child: Center(child: Text("Not now",style: TextStyle(color: AppColors.primaryColor.withOpacity(0.7))
                            ,)),
                        ),
                      ),


                    ],
                  )
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
