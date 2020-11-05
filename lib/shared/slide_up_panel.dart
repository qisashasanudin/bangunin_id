import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SlideUpPanel extends StatefulWidget {
  final List<Widget> children;
  final Widget floatingButton;
  SlideUpPanel({Key key, List<Widget> children, this.floatingButton})
      : this.children = children ?? [];

  @override
  _SlideUpPanelState createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
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
        minChildSize: 0.1,
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
