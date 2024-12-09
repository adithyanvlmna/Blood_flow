// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:blood_donation_app/Firebase_DB/crud.dart';
import 'package:blood_donation_app/Model/donators.dart';
import 'package:blood_donation_app/Utilities/routes.dart';
import 'package:blood_donation_app/ViewModel/donor_provider.dart';
import 'package:blood_donation_app/ViewModel/logined_user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading1 = false;
  bool isLoading = false;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var updatenameController = TextEditingController();
  var updatephoneController = TextEditingController();
  var updateBloodgroupController = TextEditingController();
  String? bloodGroup;
  int indexNum = 0;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DonorProvider>(context, listen: false);
    final provider1 = Provider.of<LoginedUserProvider>(context, listen: false);
    provider1.getSingleUser();
    provider.getUsers();
    provider.loadImage();
    List l1 = [
      Consumer<DonorProvider>(builder: (context, data, _) {
        return data.usersGetter.isNotEmpty
            ? ListView.builder(
                itemCount: data.usersGetter.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      tileColor: const Color.fromARGB(255, 44, 44, 44),
                      textColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          data.usersGetter[index].bloodGroup,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      title: Text("Name : ${data.usersGetter[index].name}"),
                      subtitle:
                          Text("Phone : ${data.usersGetter[index].phnone}"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                })
            : const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 44, 44, 44),
                ),
            );
      }),
      Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: nameController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 44, 44, 44),
                    labelText: "Name",
                    labelStyle: const TextStyle(color: Colors.white),
                    errorStyle: const TextStyle(color: Colors.red),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: phoneController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Phone number is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 44, 44, 44),
                    labelText: "Phone",
                    labelStyle: const TextStyle(color: Colors.white),
                    errorStyle: const TextStyle(color: Colors.red),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.arrow_drop_down),
                  validator: (value) {
                    if (value == null) {
                      return "Blood group is required";
                    }
                    return null;
                  },
                  value: bloodGroup,
                  items: const [
                    DropdownMenuItem(
                      value: "A+",
                      child: Text("A+"),
                    ),
                    DropdownMenuItem(
                      value: "A-",
                      child: Text("A-"),
                    ),
                    DropdownMenuItem(
                      value: "B+",
                      child: Text("B+"),
                    ),
                    DropdownMenuItem(
                      value: "B-",
                      child: Text("B-"),
                    ),
                    DropdownMenuItem(
                      value: "AB+",
                      child: Text("AB+"),
                    ),
                    DropdownMenuItem(
                      value: "AB-",
                      child: Text("AB-"),
                    ),
                    DropdownMenuItem(
                      value: "O+",
                      child: Text("O+"),
                    ),
                    DropdownMenuItem(
                      value: "O-",
                      child: Text("O-"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      bloodGroup = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color.fromARGB(255, 44, 44, 44),
                  iconEnabledColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 44, 44, 44),
                    filled: true,
                    labelText: "Blood Group",
                    labelStyle: const TextStyle(color: Colors.white),
                    errorStyle: const TextStyle(color: Colors.red),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: MaterialButton(
                  elevation: 10,
                  onPressed: () async {
                    final pref = await SharedPreferences.getInstance();
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading1 = true;
                      });
                      Donators donor = Donators(
                          name: nameController.text,
                          bloodGroup: bloodGroup!,
                          phnone: phoneController.text);
                      CollectionReference users;
                      DocumentReference docRef;
                      String documentId;
                      CollectionOperations.createCollection("Donors")
                          .then((data) {
                        users = data;
                        CollectionOperations.addDocumentToCollection(
                                users, donor.toMap())
                            .then((value) {
                          docRef = value;
                          documentId = docRef.id;
                          pref.setString("doccumentId", documentId);
                          print(documentId);
                          nameController.clear();
                          phoneController.clear();
                          if (documentId.isNotEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Donor added successfully",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )));
                            setState(() {
                              isLoading1 = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    elevation: 30,
                                    backgroundColor: Color(0xFFF28B81),
                                    content: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Something went wrong",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )));
                          }
                        });
                      });
                      provider.getUsers();
                    }
                  },
                  color: const Color.fromARGB(255, 44, 44, 44),
                  textColor: Colors.white,
                  minWidth: 150,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: isLoading1 == false
                      ? const Text("Submit")
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        )),
            ),
            const SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 44, 44),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (value) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: SizedBox(
                                      height: 450,
                                      child: AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Update",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        content: Form(
                                          key: formKey1,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller:
                                                        updatenameController,
                                                    cursorColor: Colors.white,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Name is required";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            const Color.fromARGB(
                                                                255, 44, 44, 44),
                                                        labelText: "Name",
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        errorStyle:
                                                            const TextStyle(
                                                                color:
                                                                    Colors.red),
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder: UnderlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10))),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller:
                                                        updatephoneController,
                                                    cursorColor: Colors.white,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Phone number is required";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            const Color.fromARGB(
                                                                255, 44, 44, 44),
                                                        labelText: "Phone",
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        errorStyle:
                                                            const TextStyle(
                                                                color:
                                                                    Colors.red),
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder: UnderlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10))),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller:
                                                        updateBloodgroupController,
                                                    cursorColor: Colors.white,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Blood group is required";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            const Color.fromARGB(
                                                                255, 44, 44, 44),
                                                        labelText:
                                                            "Blood group",
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        errorStyle:
                                                            const TextStyle(
                                                                color:
                                                                    Colors.red),
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder: UnderlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10))),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () async {
                                                    final pref =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? docId =
                                                        pref.getString(
                                                            "doccumentId");
                                                    if (formKey1.currentState!
                                                        .validate()) {
                                                      var user = Donators(
                                                          name:
                                                              updatenameController
                                                                  .text,
                                                          bloodGroup:
                                                              updateBloodgroupController
                                                                  .text,
                                                          phnone:
                                                              updatephoneController
                                                                  .text);
                                                      CollectionOperations
                                                          .updateDocumet(
                                                              "Donors",
                                                              docId!,
                                                              user.toMap());
                                                      provider.getUsers();
                                                      Navigator.pop(context);
                                                      updateBloodgroupController
                                                          .clear();
                                                      updatenameController
                                                          .clear();
                                                      updatephoneController
                                                          .clear();
                                                    }
                                                  },
                                                  color: const Color.fromARGB(
                                                      255, 44, 44, 44),
                                                  textColor: Colors.white,
                                                  minWidth: 80,
                                                  height: 50,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Text("Update"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          iconAlignment: IconAlignment.start,
                          style: const ButtonStyle(
                              iconColor: WidgetStatePropertyAll(Colors.white)),
                          icon: const Icon(Icons.edit),
                          label: const Text(
                            "Edit",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ),
                  Card(
                    child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 44, 44, 44),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton.icon(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await Future.delayed(const Duration(seconds: 1));

                            final pref = await SharedPreferences.getInstance();
                            String? docId = pref.getString("doccumentId");

                            if (docId != null) {
                              await CollectionOperations.deleteDocumet(
                                  "Donors", docId);
                              provider.getUsers();
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          iconAlignment: IconAlignment.start,
                          style: const ButtonStyle(
                            iconColor: WidgetStatePropertyAll(Colors.white),
                          ),
                          icon: const Icon(Icons.delete),
                          label: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 12.0, right: 12.0),
            child: Card(
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 44, 44),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child:
                          Consumer<DonorProvider>(builder: (context, data, _) {
                        return CircleAvatar(
                          backgroundImage: data.imageGetter != null
                              ? FileImage(data.imageGetter!)
                              : const NetworkImage(
                                  "https://icons.veryicon.com/png/o/miscellaneous/bitisland-world/person-18.png"),
                          radius: 50,
                          backgroundColor:
                              const Color.fromARGB(255, 44, 44, 44),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80, left: 63),
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (value) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: SizedBox(
                                            width: 400,
                                            height: 400,
                                            child: Column(
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  width: double.infinity,
                                                  height: 250,
                                                  child:
                                                      data.imageGetter != null
                                                          ? Image.file(
                                                              data.imageGetter!,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.network(
                                                              "https://icons.veryicon.com/png/o/miscellaneous/bitisland-world/person-18.png",
                                                            ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  color: Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              await provider
                                                                  .pickImage();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            color: const Color
                                                                .fromARGB(255,
                                                                44, 44, 44),
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              size: 20,
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              provider
                                                                  .deleteimage();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            color: const Color
                                                                .fromARGB(255,
                                                                44, 44, 44),
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              size: 20,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                color: Colors.white,
                                splashColor: Colors.white,
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                )),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<LoginedUserProvider>(builder: (context, data, _) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: data.nameGetter == null
                              ? const Text(
                                  "Adithyan",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : Text(data.emailGetter!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20)));
                    })
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
            child: Card(
              child: Consumer<LoginedUserProvider>(builder: (context, data, _) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  iconColor: Colors.white,
                  title: data.nameGetter != null
                      ? Text(
                          "Name : ${data.nameGetter}",
                          style: const TextStyle(color: Colors.white),
                        )
                      :const Text("No data"),
                  textColor: Colors.white,
                  tileColor: const Color.fromARGB(255, 44, 44, 44),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                );
              }),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
            child: Card(
              child: Consumer<LoginedUserProvider>(builder: (context, data, _) {
                return ListTile(
                  leading: const Icon(Icons.phone),
                  iconColor: Colors.white,
                  title: data.phoneGetter != null
                      ? Text(
                          "Phone : ${data.phoneGetter}",
                          style: const TextStyle(color: Colors.white),
                        )
                      : const Text("Nodata"),
                  textColor: Colors.white,
                  tileColor: const Color.fromARGB(255, 44, 44, 44),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                );
              }),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
            child: Card(
              child: ListTile(
                onTap: () async {
                  final pref = await SharedPreferences.getInstance();
                  pref.clear();
                  Navigator.pushNamed(context, Routes.loginview);
                },
                iconColor: Colors.white,
                leading: const Icon(Icons.logout),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                tileColor: const Color.fromARGB(255, 44, 44, 44),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    ];
    return Scaffold(
        body: l1.elementAt(indexNum),
        bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) {
              setState(() {
                indexNum = index;
              });
            },
            animationDuration: const Duration(milliseconds: 300),
            color: const Color.fromARGB(255, 44, 44, 44),
            backgroundColor: Colors.white,
            items: const [
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: "Home",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15)),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: "Form",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15)),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: "Profile",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15)),
            ]));
  }
}
