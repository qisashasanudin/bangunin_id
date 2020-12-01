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
      elevation: 10,
      shadowColor: Color(0x802196F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Rincian Proyek',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text('Proyek ${child.projectName}'),
            if (child.address != null)
              Text(
                '${child.address ?? '(Alamat kosong)'}',
                overflow: TextOverflow.ellipsis,
              ),
            if (child.clientName != null &&
                (child.clientPhone != null || child.clientEmail != null))
              Text(
                  '${child.clientName ?? '(Nama klien kosong)'} - ${child.clientPhone ?? child.clientEmail ?? '(Kontak klien kosong)'}'),
            Text("Tanggal mulai: ${_dateFormatter.format(child.dateCreated)}"),
            Text("Tenggat waktu: ${_dateFormatter.format(child.dateDeadline)}"),
          ],
        ),
      ),
    );
  }
}
