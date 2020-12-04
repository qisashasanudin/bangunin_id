import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/transparent_appbar_and_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverPage extends StatefulWidget {
  SliverPage({
    Key key,
    List<Widget> children,
    this.title,
    this.backgroundImage,
    this.floatingButton,
  }) : this.children = children ?? [];

  final List<Widget> children;
  final Text title;
  final Image backgroundImage;
  final Widget floatingButton;

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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors().accent1,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          customSliverAppBar(screenHeight),
          for (var element in widget.children) element,
        ],
      ),
      floatingActionButton: widget.floatingButton,
    );
  }

  SliverAppBar customSliverAppBar(double screenHeight) {
    return SliverAppBar(
      elevation: 0,
      stretch: true,
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: screenHeight / 3,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 30, bottom: 40),
            background: widget.backgroundImage,
            title: widget.title,
            stretchModes: [
              StretchMode.zoomBackground,
            ],
          ),
          Positioned(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75))
                ],
                color: AppColors().accent1,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
            ),
            bottom: -1,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }
}
