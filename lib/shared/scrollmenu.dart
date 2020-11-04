import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollMenu extends StatefulWidget {
  final List<Widget> children;
  final Widget floatingButton;
  ScrollMenu({Key key, List<Widget> children, this.floatingButton})
      : this.children = children ?? [];

  @override
  _ScrollMenuState createState() => _ScrollMenuState();
}

class _ScrollMenuState extends State<ScrollMenu> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: DraggableScrollableSheet(
        initialChildSize:
            (MediaQuery.of(context).orientation == Orientation.portrait)
                ? 0.65
                : 0.3,
        minChildSize: 0.2,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                padding: const EdgeInsets.only(top: 10.0),
                decoration: scrollMenuDecoration(),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: widget.children,
                ),
              ),
              floatingActionButton: widget.floatingButton,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          );
        },
      ),
    );
  }
}
