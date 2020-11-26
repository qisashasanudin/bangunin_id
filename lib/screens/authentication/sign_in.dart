import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/input_box_border.dart';
import 'package:bangunin_id/shared/UI_components/login_bground.dart';
import 'package:bangunin_id/shared/UI_components/login_logo.dart';
import 'package:bangunin_id/shared/UI_components/submit_button.dart';
import 'package:bangunin_id/shared/UI_components/transparent_appbar_and_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/loading_screen.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({
    @required this.toggleView,
  });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _hidePass = true;

  //text field state

  String email = '';
  String password = '';
  String error = '';
  TextEditingController emailController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingScreen();
    } else {
      return Scaffold(
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
                    passwordForm(),
                    SizedBox(height: 10.0),
                    forgotPassword(),
                    SizedBox(height: 20.0),
                    submitButton('Login', uploadData),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(height: 20.0),
                    switchToRegister(),
                  ],
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
      decoration: inputBoxBorder('Email'),
      initialValue: email,
      validator: (val) => (val.isEmpty | !val.contains('@'))
          ? 'Masukkan email yang valid'
          : null,
      onChanged: (val) {
        setState(() => email = val);
      },
    );
  }

  TextFormField passwordForm() {
    return TextFormField(
      decoration: inputBoxBorder('Password')
          .copyWith(suffixIcon: togglePassVisibility()),
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

  InkWell forgotPassword() {
    return InkWell(
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'Lupa password?',
          style: TextStyle(
            color: AppColors().accent2,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () async {
        //Belum jadi, harusnya ada screen ganti password
      },
    );
  }

  void uploadData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String result = await _auth.signInWithEmail(email, password);
      setState(() {
        error = result;
        loading = false;
      });
    }
  }

  InkWell switchToRegister() {
    return InkWell(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Belum memiliki akun? ",
              style: TextStyle(
                color: AppColors().accent2,
              ),
            ),
            Text(
              "Daftar di sini.",
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
