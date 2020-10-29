import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : WillPopScope(
            onWillPop: () async {
              widget.toggleView();
            },
            child: Scaffold(
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset(
                              'assets/img/signupimg.jpg',
                              width: 350,
                              height: 240,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.only(right: 230.0),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(labelText: "Email"),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) =>
                                    (val.isEmpty | !val.contains('@'))
                                        ? "Masukkan email yang valid"
                                        : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration:
                                    InputDecoration(labelText: "Password"),
                                obscureText: true,
                                validator: (val) => val.length < 6
                                    ? "Masukkan password (6 huruf atau lebih)"
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Confirm Password"),
                                obscureText: true,
                                validator: (val) => val != password
                                    ? "Kedua password harus sama"
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                              SizedBox(height: 48),
                              InkWell(
                                child: Container(
                                  alignment: Alignment(1.0, 1.0),
                                  width: 151,
                                  height: 46,
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      "Sign up",
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
                                    setState(
                                      () {
                                        loading = true;
                                      },
                                    );
                                    dynamic result = await _auth
                                        .registerWithEmail(email, password);
                                    if (result == null) {
                                      setState(
                                        () {
                                          error = 'Registrasi tidak berhasil.';
                                          loading = false;
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
