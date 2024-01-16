import 'package:deardiary/app/home_page.dart';
import 'package:deardiary/app_theme.dart';
import 'package:deardiary/user_authentication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name = '';
  String _emailAddress = '';
  String _pwd = '';

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/gr_bg.png'),
                  fit: BoxFit.cover,
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
                      Text("Create", style: MyStyles.kbigtext_auth),
                      Text("Account", style: MyStyles.kbigtext_auth),
                      SizedBox(height: 90),
                      // Use a Column instead of ListView
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: MyStyles.khinttext_auth,
                              filled: false,
                            ),
                          ),
                          SizedBox(height: 19),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _emailAddress = value;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: MyStyles.khinttext_auth,
                              filled: false,
                            ),
                          ),
                          SizedBox(height: 19),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _pwd = value;
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
                          SizedBox(height: 82),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("SIGNUP", style: MyStyles.kmediumtext_auth),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 60.0,
                                  color: Color(0xFF27672E),
                                ),
                                onPressed: () async {
                                  // Your signup logic
                                   try{
                                       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                           email: _emailAddress,
                                           password: _pwd,
                                       );
                                       Navigator.pushNamed(context, 'home');
                                   } on FirebaseAuthException catch (e){
                                         String errorMessage='';

                                         if(e.code=='weak-password'){
                                           errorMessage='The password provided is too weak';
                                         }else if(e.code=='email-already-in-use'){
                                           errorMessage='The account already exists for that email' ;
                                         } else {
                                           errorMessage='An error occurred. Please try again';
                                         }

                                         _scaffoldKey.currentState?.showSnackBar(
                                           SnackBar(
                                               content: Text(errorMessage),
                                             duration: Duration(seconds: 3),
                                           )
                                         );
                                   }  catch (e) {
                                     print(e);
                                     _scaffoldKey.currentState?.showSnackBar(
                                       SnackBar(
                                           content: Text('An unexpected error occurred.')  ,
                                         duration: Duration(seconds: 3),
                                       ),
                                     );
                                   }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          TextButton(
                            onPressed: () {
                              // Your sign-in logic
                              Navigator.pushNamed(context, 'log-in');
                            },
                            child: Text(
                              'Sign-in',
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
    );
  }
}

