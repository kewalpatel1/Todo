import 'package:todo/authenticate/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screen/signin.dart';
import 'homepage.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  AuthMethods authMethods = new AuthMethods();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  signIn() async {
    if (formKey.currentState!.validate()) {
      await authMethods
          .signInWithEmailAndPassword(
          emailcontroller.text, passwordcontroller.text)
          .then((result) async {
        print("$result");
        if (result != null)  {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          setState(() {
            isLoading = false;
          });
        }
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
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back!",
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
                    controller: emailcontroller,
                    validator: (val) {
                      return val!.isNotEmpty  ? null : "Enter your username";
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText:"John deo"
                    ),
                  ),
                  SizedBox(height:30,),
                  Text("Password",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                      null : "Enter correct password";
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    obscureText: true,

                    decoration: InputDecoration(
                        hintText:"Enter your password"
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Text("Forget password? ",
                          style: TextStyle(
                                fontSize: 16.0,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 90,),
                  Container(
                    height: 60,
                    child: Material(
                      borderRadius: BorderRadius.circular(16.0),
                      color:Color(0xFF9890e3),
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                         signIn();
                        },
                        child: Center(
                          child: Text(
                            'Login',
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
                              builder: (context) => Signin())
                          );
                        },
                        child: Text("Create account ",
                          style: TextStyle(
                              fontSize: 16.0,
                            fontStyle:FontStyle.italic
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}


