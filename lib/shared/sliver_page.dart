import 'package:bangunin_id/shared/UI_templates.dart'; // sumber AppColors()
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
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors().accent1,
        body: CustomScrollView(
          slivers: widget.children,
        ),
      ),
    );
  }
}
