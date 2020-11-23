import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/slide_up_marker.dart';
import 'package:flutter/material.dart';

class SlideUpPanel extends StatefulWidget {
  final List<Widget> children;
  final String tabTitle;
  final Widget floatingButton;

  SlideUpPanel(
      {Key key, List<Widget> children, this.floatingButton, String tabTitle})
      : this.children = children ?? [],
        this.tabTitle = tabTitle ?? '';

  @override
  _SlideUpPanelState createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                boxShadow: [
                  BoxShadow(color: Colors.grey[700], blurRadius: 10.0)
                ],
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  controller: scrollController,
                  children: <Widget>[
                    SlideUpMarker(),
                    tabTitle(widget.tabTitle),
                    for (var element in widget.children) element,
                  ],
                ),
              ),
            ),
            floatingActionButton: widget.floatingButton,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }

  AppBar tabTitle(String tabTitle) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(tabTitle, style: TextStyle(color: AppColors().accent2)),
      actions: <Widget>[
        if (tabTitle == 'Beli Material' || tabTitle == 'Beranda')
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey),
            onPressed: () {},
          ),
        if (tabTitle == 'Beli Material')
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.grey),
            onPressed: () {},
          ),
        if (tabTitle == 'Beranda')
          IconButton(
            icon: Icon(Icons.sort, color: Colors.grey),
            onPressed: () {},
          ),
      ],
    );
  }
}
