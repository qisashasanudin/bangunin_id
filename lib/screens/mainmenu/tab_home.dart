import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  //Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<User>(context).uid;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: DraggableScrollableSheet(
        initialChildSize: (MediaQuery.of(context).orientation == Orientation.portrait)
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
                  slivers: [
                    SliverToBoxAdapter(
                      child: pullDownMarker(),
                    ),
                    SliverToBoxAdapter(
                      child: projectDone(),
                    ),
                    SliverToBoxAdapter(
                      child: projectInProgress(),
                    ),
                    SliverList(
                      delegate: infiniteList(context),
                    )
                  ],
                ),
              ),
              floatingActionButton:
                  createProjectButton(userID), // hanya untuk mandor
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          );
        },
      ),
    );
  }
}

Center pullDownMarker() {
  return Center(
    child: Container(
      height: 8,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors().accent3,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

Padding projectDone() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: ListTile(
      title: Text('Project Done'),
      subtitle: Text('2'),
    ),
  );
}

Padding projectInProgress() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: ListTile(
      title: Text('Project in progress'),
      subtitle: Text('3'),
    ),
  );
}

SliverChildBuilderDelegate infiniteList(BuildContext context) {
  return SliverChildBuilderDelegate(
    (BuildContext context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors().accent3,
            borderRadius: BorderRadius.circular(100),
          ),
          child: ListTile(
            title: Text("Proyek $index"),
            subtitle: Text("Deadline: -"),
            trailing: Text(
              "In - progress",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              Navigator.of(context).pushNamed('/projectdetails');
            },
          ),
        ),
      );
    },
  );
}

StreamBuilder createProjectButton(String userID) {
  return StreamBuilder(
    stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data.data['isSupervisor']) {
        return FloatingActionButton.extended(
          onPressed: () async {
            Navigator.of(context).pushNamed('/newproject');
          },
          label: Text(
            'Buat Proyek Baru',
            style: TextStyle(color: AppColors().accent1),
          ),
          backgroundColor: AppColors().primary,
        );
      } else {
        return Container();
      }
    },
  );
}
