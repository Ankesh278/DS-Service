import 'package:flutter/material.dart';

class Payment1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60,),
      const Icon(Icons.arrow_back_ios_new_sharp,),
          const SizedBox(height: 20,
          ),
          Container(width: double.infinity,height: 151,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How is the customer paying?',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                Spacer(),
                Text('₹ 3394',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),
          ),
          const SizedBox(height: 250,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(width: 99,height: 99,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black,width: 2)
                ),
                child: const Column(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book_online_sharp,size: 30,),
                    SizedBox(height: 5,),
                    Text('Online',style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
              Container(width: 99,height: 99,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black,width: 2)
                ),
                child: const Column(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.money,size: 30,),
                    SizedBox(height: 5,),
                    Text('Cash',style: TextStyle(fontSize: 20),)
                  ],
                ),
              )
            ],
          ),
          Spacer(),
          Center(
            child: Container(width: 264,height: 36,
              margin: EdgeInsets.only(bottom: 40,),
              decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
              child: Center(child: Text('Select payment type to continue',style: TextStyle(color: Colors.white),),),),
          ),

        ],

      ),
    ),
    );
  }
}
