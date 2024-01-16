import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _password = '';
  String _emailAddress = '';

  //for snackBar
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width; // L for Landscape
    double screenHeight = MediaQuery.of(context).size.height; // B for Both Portrait and Landscape

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              //background image
              Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/gr_bg.png'),
                    fit: BoxFit.cover, // fit as needed
                  ),
                ),
              ),
              // Design Elements on Top
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 100, 30, 40),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome", style: MyStyles.kbigtext_auth,),
                        Text("Back", style: MyStyles.kbigtext_auth,),
                        SizedBox(height: 120,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _emailAddress=value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: MyStyles.khinttext_auth,
                                filled: false,
                              ),
                            ),
                            SizedBox(height: 22,),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _password=value;
                                });
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: MyStyles.khinttext_auth,
                                filled: false,
                              ),
                            ),
                            SizedBox(height: 45+22+22+33,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("LOGIN", style: MyStyles.kmediumtext_auth,),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    size: 60.0,
                                    color: Color(0xFF27672E),
                                  ),
                                  onPressed: () async{
                                    try {
                                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: _emailAddress,
                                        password: _password,
                                      );
                                      Navigator.pushNamed(context, 'home');
                                    } on FirebaseAuthException catch (e) {
                                      String errorMessage = '';
                                      if (e.code == 'user-not-found') {
                                        errorMessage = 'No user found for that email.';
                                      } else if (e.code == 'wrong-password') {
                                        errorMessage = 'Wrong password provided for that user.';
                                      } else {
                                        errorMessage = 'An error occurred. Please try again.';
                                      }

                                      _scaffoldKey.currentState?.showSnackBar(
                                        SnackBar(
                                          content: Text(errorMessage),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    } catch (e) {
                                      print(e);
                                      _scaffoldKey.currentState?.showSnackBar(
                                        SnackBar(
                                          content: Text('An unexpected error occurred.'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 25,),
                            TextButton(
                              onPressed: () {
                                // Handle button press
                                print('Sign-up button pressed');
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Sign-up',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFF3F6F45),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline,
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
            ],
          ),
        ),
      ),
    );
  }
}
