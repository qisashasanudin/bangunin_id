import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<ProjectDetailsModel>>(context);
    final DateFormat _dateFormatter = DateFormat('dd MMM, yyyy');

    if (projects == null) {
      return LoadingText();
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: projects.length,
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
              title: Text('Proyek ${projects[index].projectName}'),
              subtitle: Text(
                  "Deadline: ${_dateFormatter.format(projects[index].dateDeadline)}"),
              trailing: (projects[index].isCompleted == false)
                  ? Text("In-Progress", style: TextStyle(color: Colors.red))
                  : Text("Complete", style: TextStyle(color: Colors.green)),
              onTap: () async {
                Navigator.of(context).pushNamed('/projectdetails');
              },
            ),
          ),
        );
      },
    );
  }
}
