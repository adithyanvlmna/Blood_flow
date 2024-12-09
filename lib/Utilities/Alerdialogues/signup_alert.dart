import 'package:blood_donation_app/Utilities/routes.dart';
import 'package:flutter/material.dart';

void singupAlert(
    {required String title, required String content, context, action}) {
  showDialog(
      context: context,
      builder: (value) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child:SizedBox(
              height: 400,
              width: 400,
              child: Column(children: [
               action != null
                ? AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color.fromARGB(255, 44, 44, 44)
,
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(title,style:const TextStyle(color: Colors.white),)),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(content,style:const TextStyle(color: Colors.white),),
                    ),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.loginview);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        textColor: const Color.fromARGB(255, 44, 44, 44)
,
                        height: 40,
                        splashColor: Colors.white10,
                        child: Text(action),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        textColor: const Color.fromARGB(255, 44, 44, 44)
,
                        height: 40,
                        splashColor: Colors.white10,
                        child: const Text("Ok"),
                      ),
                    ],
                  )
                : AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 44, 44, 44)
,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: Text(title,style:const TextStyle(color: Colors.white,fontSize: 25),),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(content,style:const TextStyle(color: Colors.white,fontSize: 15),),
                    ),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white
,
                        textColor: const Color(0xFFF28B81)
,
                        height: 40,
                        splashColor: Colors.white10,
                        child: const Text("Ok"),
                      ),
                    ],
                  )
            ],),));
      });
}
