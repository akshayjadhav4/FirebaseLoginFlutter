import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //init firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance; //Create connection with firebase
  //Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //elements of form
  String _email;
  String _password;

  checkAuthentication() async{
    _auth.onAuthStateChanged.listen((user) async{
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSignUpScreen(){
    Navigator.pushReplacementNamed(context, "/SignUpPage");
  }

  @override
  void initState() {
      super.initState();
     this.checkAuthentication();
    }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser  user = await _auth.signInWithEmailAndPassword(email: _email,password: _password);

      } catch (e) {
        showError(e.message);
      }
    }
  }

    showError(String errorMessage){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child: Image(
                  image: AssetImage("images/logo.png"),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      //Email
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          validator:(input){
                            if (input.isEmpty) {
                              return 'Provide an email';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                          ),
                          onSaved: (input) =>_email = input,
                        ),
                      ),
                      //Password
                       Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          validator:(input){
                            if (input.length >6) {
                              return 'Password should 6 character at least';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                          ),
                          onSaved: (input) =>_password = input,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          onPressed: signIn,
                          child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20 , 0, 20),
                      ),
                      //Redirect to signup page
                      GestureDetector(
                        onTap: navigateToSignUpScreen,
                        child: Text('Create an account',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0),),
                      )
                    ],
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