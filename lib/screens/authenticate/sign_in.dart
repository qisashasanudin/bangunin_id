import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Container(
                          child: Image.asset('assets/img/logo.png',
                              height: 113, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: Text(
                            "Welcome,",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: Text(
                            "Sign in to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(labelText: "Email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val.isEmpty ? 'Masukkan email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(labelText: "Password"),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Masukkan password (6 huruf atau lebih)'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 15.0),
                        InkWell(
                          child: Container(
                            alignment: Alignment(1.0, 1.0),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            //Belum jadi, harusnya ada screen ganti password
                          },
                        ),
                        SizedBox(height: 25.0),
                        InkWell(
                          child: Container(
                            alignment: Alignment(1.0, 1.0),
                            width: 151,
                            height: 46,
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.signInWithEmail(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Login tidak berhasil. Periksa kembali email, password, dan koneksi internet anda.';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(height: 15.0),
                        InkWell(
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account? "),
                                  Text(
                                    "Sign up now!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: "Open Sans",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            widget.toggleView();
                          },
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
