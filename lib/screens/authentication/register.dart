import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:bangunin_id/screens/transitions/loading.dart';

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
  bool _hidePass = true;
  bool _hidePassConfir = true;

  //text field state
  String email = '';
  String name = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingScreen();
    } else {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: transparentAppbarAndNavbar()
            .copyWith(statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors().accent1,
          body: Container(
            decoration: loginBground(),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      loginLogo(),
                      SizedBox(height: 40.0),
                      emailForm(),
                      SizedBox(height: 20.0),
                      nameForm(),
                      SizedBox(height: 20.0),
                      passwordForm(),
                      SizedBox(height: 20.0),
                      passwordConfirForm(),
                      SizedBox(height: 20.0),
                      submitButton('Daftar'),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(height: 20.0),
                      switchToLogin(),
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

  TextFormField emailForm() {
    return TextFormField(
      decoration: inputBoxBorder().copyWith(hintText: 'Email'),
      validator: (val) => (val.isEmpty | !val.contains('@'))
          ? 'Masukkan email yang valid'
          : null,
      onChanged: (val) {
        setState(() => email = val);
      },
    );
  }

  TextFormField nameForm() {
    return TextFormField(
      decoration: inputBoxBorder().copyWith(hintText: 'Nama Lengkap'),
      validator: (val) => (val.isEmpty) ? 'Masukkan nama lengkap anda' : null,
      onChanged: (val) {
        setState(() => name = val);
      },
    );
  }

  TextFormField passwordForm() {
    return TextFormField(
      decoration: inputBoxBorder()
          .copyWith(hintText: 'Password', suffixIcon: togglePassVisibility()),
      obscureText: _hidePass,
      validator: (val) =>
          val.length < 6 ? 'Masukkan password (6 huruf atau lebih)' : null,
      onChanged: (val) {
        setState(() => password = val);
      },
    );
  }

  GestureDetector togglePassVisibility() {
    return GestureDetector(
      child: Icon(
        (_hidePass ? Icons.visibility : Icons.visibility_off),
        color: Colors.grey,
      ),
      onTap: () {
        setState(() {
          _hidePass = !_hidePass;
        });
      },
    );
  }

  TextFormField passwordConfirForm() {
    return TextFormField(
      decoration: inputBoxBorder().copyWith(
          hintText: 'Konfirmasi password',
          suffixIcon: togglePassConfirVisibility()),
      obscureText: _hidePassConfir,
      validator: (val) => val != password ? 'Kedua password harus sama' : null,
    );
  }

  GestureDetector togglePassConfirVisibility() {
    return GestureDetector(
      child: Icon(
        (_hidePassConfir ? Icons.visibility : Icons.visibility_off),
        color: Colors.grey,
      ),
      onTap: () {
        setState(() {
          _hidePassConfir = !_hidePassConfir;
        });
      },
    );
  }

  SizedBox submitButton(promptText) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: AppColors().primary,
        child: Text(
          promptText,
          style: TextStyle(color: AppColors().accent1),
        ),
        onPressed: uploadData,
      ),
    );
  }

  void uploadData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String result = await _auth.signUpWithEmail(email, name, password);
      setState(() {
        error = result;
        loading = false;
      });
    }
  }

  InkWell switchToLogin() {
    return InkWell(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sudah memiliki akun? ",
              style: TextStyle(
                color: AppColors().accent2,
              ),
            ),
            Text(
              "Login di sini.",
              style: TextStyle(
                color: AppColors().accent2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        widget.toggleView();
      },
    );
  }
}
