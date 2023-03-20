import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Reusable/Reusable_widget.dart';
import 'Home.dart';
import 'Register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(height: 50,),
                    Center(
                        child: logoWidget("assets/images/logo.png")
          ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: reusableTextField('Enter UserName', Icons.person, false, _emailTextController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: reusableTextField('Enter Password', Icons.lock, true, _passwordTextController),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: signInSignUpButton(context, true, (){
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text).then((value){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }).onError((error, stackTrace){
                          print("Error ${error.toString()}");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Register()));
                        });

                      })
                    ),
                    signUpOption()
                  ],
                ),
        ),
    );
  }

  Row signUpOption (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?  ",style: TextStyle(color: Colors.white70),),
        GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Register()));
          },
          child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        )
      ],
    );
  }

}

