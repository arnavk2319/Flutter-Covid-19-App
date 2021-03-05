import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';
import 'package:recollection_app/main.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _success;
  String _userEmail;

  void _registerFirebaseUser() async {
    final User user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _pwdController.text
    )).user;

    if(user != null){
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    }
    else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('SignUp Activity'),
            backgroundColor: Colors.green[700],
          ),
          body: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String value) {
                        if(value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _pwdController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (String value) {
                        if(value.isEmpty) {
                          return 'Please enter your password';
                        }
                        else if(value.length < 6){
                          return 'Password should be atleast 6 characters';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            _registerFirebaseUser();
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => MyHomePage()));
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_success == null ? '' : (_success ? 'Successfully Logged In' + _userEmail : 'Registration Unsuccessful' )),
                    )
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/18,
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.black
                  ),
                  child: Center(
                      child : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/google.jpg'),
                                    fit: BoxFit.cover
                                ),
                                shape: BoxShape.circle
                            ),
                          ),
                          Text(
                            'Sign Up with Google',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                        ],
                      )
                  ),
                ),
                onTap: () {
                  googleLogin().then((result) {
                    if(result != null){
                      // print("Helllloo");
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => MyHomePage()));
                    }
                  });
                } ,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/18,
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.green
                  ),
                  child: Center(
                      child : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                        ],
                      )
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => Login()));
                } ,
              ),
              // InkWell(
              //   child: Container(
              //     width: MediaQuery.of(context).size.width/2,
              //     height: MediaQuery.of(context).size.height/18,
              //     margin: EdgeInsets.only(top: 25),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color:Colors.black
              //     ),
              //     child: Center(
              //         child : Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: <Widget>[
              //             Container(
              //               height: 40.0,
              //               width: 40.0,
              //               decoration: BoxDecoration(
              //                   image: DecorationImage(
              //                       image: AssetImage('assets/images/facebookpublisher.jpg'),
              //                       fit: BoxFit.cover
              //                   ),
              //                   shape: BoxShape.rectangle
              //               ),
              //             ),
              //             Text(
              //               'Sign In with Facebook',
              //               style: TextStyle(
              //                   fontSize: 16.0,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.white
              //               ),
              //             )
              //           ],
              //         )
              //     ),
              //   ),
              //   onTap: fbLogin,
              // ),
            ],
          )
      ),
    );
  }
}
