import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    Key key,
    @required this.children,
  }) : super(key: key);

  final List<ProjectDetailsModel> children;

  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormatter = DateFormat('dd MMM, yyyy');

    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors().accent3,
              borderRadius: BorderRadius.circular(100),
            ),
            child: ListTile(
              dense: true,
              title: Text('Proyek ${children[index].projectName}'),
              subtitle: Text(
                  "Deadline: ${_dateFormatter.format(children[index].dateDeadline)}"),
              trailing: (children[index].isCompleted == false)
                  ? Text("In-Progress", style: TextStyle(color: Colors.red))
                  : Text("Complete", style: TextStyle(color: Colors.green)),
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
}
