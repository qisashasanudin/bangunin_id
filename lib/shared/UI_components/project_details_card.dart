import 'package:bangunin_id/models/project_details_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectDetailsCard extends StatelessWidget {
  const ProjectDetailsCard({
    Key key,
    @required this.child,
  }) : super(key: key);

  final ProjectDetailsModel child;

  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormatter = DateFormat('dd MMM yyyy');
    final String dateCreated = _dateFormatter.format(child.dateCreated);
    final String dateDeadline = _dateFormatter.format(child.dateDeadline);
    final String difference =
        child.dateDeadline.difference(child.dateCreated).inDays.toString();
    final String daysRemaining =
        child.dateDeadline.difference(DateTime.now()).inDays.toString();

    return Card(
      elevation: 10,
      shadowColor: Color(0x802196F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ExpansionTile(
          title: Text('Rincian Proyek',
              style: TextStyle(fontWeight: FontWeight.bold)),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text('Proyek ${child.projectName}')),
            if (child.projectId != null && child.projectId != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('ID:  ${child.projectId}')),
            if (child.address != null && child.address != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('${child.address ?? '(Alamat kosong)'}')),
            if (child.clientName != null && child.clientName != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child:
                      Text('${child.clientName} - ${child.clientPhone ?? ''}')),
            if (child.clientEmail != null && child.clientEmail != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('${child.clientEmail ?? ''}')),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text('$dateCreated - $dateDeadline ($difference hari)')),
            if (!child.isCompleted)
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('Tersisa $daysRemaining hari lagi')),
          ],
        ),
      ),
    );
  }
}
