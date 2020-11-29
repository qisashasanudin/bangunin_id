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
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'Rincian Proyek',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text('Proyek ${child.projectName}'),
            ),
            if (child.address != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text('${child.address ?? '(Alamat kosong)'}'),
              ),
            if (child.clientName != null &&
                (child.clientPhone != null || child.clientEmail != null))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                    '${child.clientName ?? '(Nama klien kosong)'} - ${child.clientPhone ?? child.clientEmail ?? '(Kontak klien kosong)'}'),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                  "Deadline: ${_dateFormatter.format(child.dateDeadline)}"),
            ),
          ],
        ),
      ),
    );
  }
}
