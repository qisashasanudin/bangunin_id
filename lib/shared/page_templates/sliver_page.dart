import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/transparent_appbar_and_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverPage extends StatefulWidget {
  final List<Widget> children;
  final Widget floatingButton;

  SliverPage({Key key, List<Widget> children, this.floatingButton})
      : this.children = children ?? [];

  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      transparentAppbarAndNavbar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().accent1,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          for (var element in widget.children) element,
        ],
      ),
    );
  }
}
