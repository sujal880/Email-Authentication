import 'package:email_password_auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);

  @override
  State<Sign_Up> createState() => Sign_Up_Page();
}

class Sign_Up_Page extends State<Sign_Up> {
  var EmailController=TextEditingController();
  var PasswordController=TextEditingController();
  var CPasswordController=TextEditingController();

  void SignUp()async{
    String email=EmailController.text.trim();
    String password=PasswordController.text.trim();
    String cpassword=CPasswordController.text.trim();

    if(email=="" || password=="" || cpassword==""){
      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Valid Details'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Ok'))
          ],
        );
      }
      );
    }
    else if(password!=cpassword){
      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          title: Text('Your Passwords Does Not Match'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Ok'))
          ],
        );
      }
      );
    }
    else{
      try{
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
            password: password);
        if(userCredential.user!=null){
          Navigator.pop(context);
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
              TextField(
                controller: EmailController,
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
                controller: PasswordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                    )
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: CPasswordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'CPassword',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                    )
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(child: Text('Create'),color: Colors.blue, onPressed: (){
                SignUp();
              }),
              SizedBox(height: 20),
              CupertinoButton(child: Text('Sign In'),color: Colors.blue, onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Log_In()));
              })

            ],
          ),
        )
    );
  }
}
