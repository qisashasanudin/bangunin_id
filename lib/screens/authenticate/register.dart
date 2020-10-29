import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:bangunin_id/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({
    @required this.toggleView,
  });

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
    if (loading) {
      return Loading();
    } else {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: transparentAppbar(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors().accent1,
          body: Container(
            decoration: authBground(),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      authLogo(),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            inputBoxBorder().copyWith(hintText: 'Email'),
                        validator: (val) => (val.isEmpty | !val.contains('@'))
                            ? 'Masukkan email yang valid'
                            : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            inputBoxBorder().copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Masukkan password (6 huruf atau lebih)'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: inputBoxBorder()
                            .copyWith(hintText: 'Konfirmasi password'),
                        obscureText: true,
                        validator: (val) => val != password
                            ? 'Kedua password harus sama'
                            : null,
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: AppColors().primary,
                          child: Text(
                            'Daftar',
                            style: TextStyle(color: AppColors().accent1),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.registerWithEmail(
                                  email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Registrasi tidak berhasil.';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        child: Container(
                          child: Text(
                            'Sudah memiliki akun? Klik di sini.',
                            style: TextStyle(
                              color: AppColors().accent2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
