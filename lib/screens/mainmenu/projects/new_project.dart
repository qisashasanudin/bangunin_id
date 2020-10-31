import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors().accent1,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Buat Proyek Baru'),
              ),
            ),
            //Sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }
}
