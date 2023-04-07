// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';

import '../shared/data_from_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
 File? imgPath;
 uploadImage() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
              

                   Center(
                     child: Container(
                     
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 173, 168, 168)
                      ),
                      child: Stack(children: [
                      
                        imgPath == null ?
                        
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 225, 225, 225),
                          radius: 64,
                          backgroundImage: AssetImage("assets/img/avatar.png"),
                        ):
                        ClipOval(
                            child: Image.file(
                          imgPath!,
                          width: 145,
                          height: 145,
                          fit: BoxFit.cover,
                        )),
                        Positioned(
                          left: 94,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {
                              uploadImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Color.fromARGB(255, 94, 115, 128),
                            ),
                          ),
                        ),
                      ]),
                                     ),
                   ),
                   SizedBox(height: 22,),
            Center(
                child: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 131, 177, 255),
                  borderRadius: BorderRadius.circular(11)),
              child: Text(
                "Info from firebase Auth",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
               
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email: ${credential!.email}      ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "Created date:   ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}   ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  // "Created date:   ${DateFormat("MMMM d, y").format(     credential!.metadata.creationTime!   )}   ",
            
                  "Last Signed In: ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)} ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 33,),
                  Center(
               child: TextButton(
                onPressed: () {
                 CollectionReference users =  FirebaseFirestore.instance.collection('COLLECTION NAME');
                credential!.delete();
                users.doc(credential!.uid).delete();
                Navigator.pop(context);
                }, 
               child: Text("Delete User", style: TextStyle(fontSize: 22),)
               ),
             )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.all(11),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 131, 177, 255),
                        borderRadius: BorderRadius.circular(11)),
                    child: Text(
                      "Info from firebase firestore",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))),
            SizedBox(
              height: 33,
            ),
            getDataFromFirestore(
              documentId: credential!.uid,
            ),
          ],
        ),
      ),
    );
  }
}
