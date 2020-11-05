import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverPanel extends StatefulWidget {
  final List<Widget> children;
  final Widget floatingButton;
  SliverPanel({Key key, List<Widget> children, this.floatingButton})
      : this.children = children ?? [];

  @override
  _SliverPanelState createState() => _SliverPanelState();
}

class _SliverPanelState extends State<SliverPanel> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors().accent1,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: widget.children,
        ),
      ),
    );
  }
}
