import 'package:bangunin_id/models/project_details_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    Key key,
    @required this.children,
  }) : super(key: key);

  final List<ProjectDetailsModel> children;

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormatter = DateFormat('dd MMM yyyy');

    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Card(
            elevation: 10,
            shadowColor: Color(0x802196F3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              dense: true,
              title: Text('Proyek ${children[index].projectName}'),
              subtitle: Text(
                  "Deadline: ${_dateFormatter.format(children[index].dateDeadline)}"),
              trailing: (children[index].isCompleted == false)
                  ? Text("In - Progress",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ))
                  : Text("Completed",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      )),
              onTap: () async {
                Navigator.of(context).pushNamed('/projectdetails');
              },
              onLongPress: () {},
            ),
          ),
        );
      },
    );
  }
  //========================= main function =========================
}
