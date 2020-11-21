import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverSlideUpPanel extends StatefulWidget {
  final List<Widget> children;
  final Widget floatingButton;
  SliverSlideUpPanel({Key key, List<Widget> children, this.floatingButton})
      : this.children = children ?? [];

  @override
  _SliverSlideUpPanelState createState() => _SliverSlideUpPanelState();
}

class _SliverSlideUpPanelState extends State<SliverSlideUpPanel> {
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
                decoration: BoxDecoration(
                  color: AppColors().accent1,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
                ),
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
