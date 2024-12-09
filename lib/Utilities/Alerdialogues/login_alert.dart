import 'package:flutter/material.dart';

void loginAlert({required String title, required String content, context}) {
  showDialog(
      context: context,
      builder: (value) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 44, 44, 44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        )),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        content,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        textColor: const Color.fromARGB(255, 44, 44, 44),
                        height: 40,
                        splashColor: Colors.white10,
                        child: const Text("Ok"),
                      ),
                    ],
                  )
                ],
              ),
            ));
      });
}
