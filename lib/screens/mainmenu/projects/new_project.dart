import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors().accent1,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              pinned: true,
              expandedHeight: screenHeight / 4,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Buat Proyek Baru'),
                stretchModes: [
                      StretchMode.zoomBackground,
                      StretchMode.fadeTitle,
                    ],
              ),
            ),
            //Sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }
}
