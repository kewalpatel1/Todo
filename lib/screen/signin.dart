import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/authenticate/auth.dart';
import 'package:todo/screen/homepage.dart';
import 'package:todo/screen/login.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}


class _SigninState extends State<Signin> {
  bool isloading = false;
  AuthMethods authMethods = AuthMethods();
  final formkey = GlobalKey<FormState>();
  TextEditingController  usernameController = new TextEditingController();
  TextEditingController  emailController = new TextEditingController();
  TextEditingController  passwordController = new TextEditingController();

  void loading() async {
    if (formkey.currentState!.validate()){
      authMethods.signUpWithEmailAndPassword(emailController.text,
          passwordController.text).then((val){
        setState(() {
          isloading = true;
        });
        Map<String, String> userInfoMap ={
          "email": emailController.text,
          "name" : usernameController.text
        };
        Navigator.pushReplacement(
            context, MaterialPageRoute(
            builder: (context) => Home())
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body:new GestureDetector(
        onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
       },
          child:SingleChildScrollView(
               child: Padding(
                   padding: const EdgeInsets.all(20),
                     child: Form(
                       key: formkey,
                       child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                Text("Let's get started!",
                                style: GoogleFonts.averiaSansLibre(
                                  textStyle: TextStyle(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              SizedBox(height: 2,),
                              Text(" Signin to continue...",
                                style: GoogleFonts.averiaSansLibre(
                                  textStyle: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              SizedBox(height:40,),
                                  Text("User name",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                    ),
                                  ),
                            TextFormField(
                              controller: usernameController,
                              validator: (val) {
                                return val!.isNotEmpty || val.length > 4 ? null : "Enter your username";
                              },
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText:"John deo"
                              ),
                            ),
                                  SizedBox(height:30,),

                                  Text("User email",
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                            TextFormField(
                              controller:emailController ,
                              validator: (val) {
                                return val!.isNotEmpty || val.length > 4 ?
                                null : "Enter correct email";
                              },
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText:"John deo@gmail.com"
                              ),
                            ),
                              SizedBox(height:30,),
                              Text("Password",
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                            TextFormField(
                              controller: passwordController,
                              validator: (val) {
                                return val!.length>6 ? null : "Enter the password";
                              },

                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText:"Enter your password"
                              ),
                            ),
                        SizedBox(height: 90,),
                        Container(
                          height: 60,
                          child: Material(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Color(0xFFff9a9e),
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                loading();
                              },
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ),
                    SizedBox(height: 25,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => Login())
                              );
                            },
                            child: Text("Already have an account? ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle:FontStyle.italic
                              ),
                            ),
                          ),
                        ],
                ),
              ]
              ),
                     ),
              ),
    ),
      ),

    );
  }
}
