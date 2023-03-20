import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/Login&Register/Home.dart';

import '../Reusable/Reusable_widget.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8,1),
    colors: <Color>[
    Color(0xff1f005c),
    Color(0xff5b0060),
    Color(0xff870160),
    Color(0xffac255e),
    Color(0xffca485c),
    Color(0xffe16b5c),
    Color(0xfff39060),
    Color(0xffffb56b),
    ],
    tileMode: TileMode.mirror
    )
    ),
          child:
          Column(
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: reusableTextField('Enter UserName', Icons.person, false, _userNameTextController),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: reusableTextField('Enter Email', Icons.person, false, _emailTextController),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: reusableTextField('Enter Password', Icons.lock, true, _passwordTextController),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: signInSignUpButton(context, false, (){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then((value){
                        print("Created Successful");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }).onError((error, stackTrace){
                    print("Error ${error.toString()}");
                  });

                }),
              ),
            ],
          ),
        ),
    );
  }
}
