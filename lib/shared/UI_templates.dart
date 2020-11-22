import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  final primary = const Color(0xffffc000);
  final accent1 = Colors.white;
  final accent2 = Colors.black;
  final accent3 = Colors.grey[300];
  AppColors();
}

SystemUiOverlayStyle transparentAppbarAndNavbar() {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

class SlideUpMarker extends StatelessWidget {
  const SlideUpMarker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: Container(
          height: 8,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors().accent3,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

ClipRRect loginLogo() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Image.asset(
      "assets/img/logo.jpg",
      height: 120,
      width: 120,
      fit: BoxFit.fill,
    ),
  );
}

BoxDecoration loginBground() {
  return BoxDecoration(
    image: DecorationImage(
      alignment: Alignment.bottomCenter,
      image: AssetImage('assets/img/auth_bg.jpg'),
      colorFilter: new ColorFilter.mode(
          Colors.black.withOpacity(0.4), BlendMode.dstATop),
    ),
  );
}

InputDecoration inputBoxBorder() {
  return InputDecoration(
    fillColor: Colors.grey[350],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[350], width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors().primary, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors().primary, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
  );
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
    @required this.textHint,
  }) : super(key: key);

  final String textHint;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 3),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Icon(Icons.search, size: 30),
          ),
          hintText: widget.textHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
