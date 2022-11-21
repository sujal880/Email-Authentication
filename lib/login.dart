import 'package:email_password_auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class Log_In extends StatefulWidget {
  const Log_In({Key? key}) : super(key: key);

  @override
  State<Log_In> createState() => _Log_InState();
}

class _Log_InState extends State<Log_In> {
  var Email=TextEditingController();
  var password=TextEditingController();

  void Login()async{
    String email=Email.text.trim();
    String Password=password.text.trim();

    if(email==""||Password==""){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Valid Details'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Ok'))
          ],
        );
      });
    }
    else{
      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: Password);
      try{
        if(userCredential!=null){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
        }
    }on FirebaseAuthException catch(ex){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(ex.code.toString()),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Ok'))
            ],
          );
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: Email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: password,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  )
              ),
            ),
            SizedBox(height: 20),
            CupertinoButton(child: Text('LogIn'),color: Colors.blue, onPressed: (){
              Login();
            }),
            SizedBox(height: 20),
            CupertinoButton(child: Text('Sign Up'),color: Colors.blue, onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_Up()));
            })

          ],
        ),
      )
    );
  }
}
