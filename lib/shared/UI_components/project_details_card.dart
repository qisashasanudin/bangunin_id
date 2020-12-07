import 'package:bangunin_id/models/project_details_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectDetailsCard extends StatefulWidget {
  const ProjectDetailsCard({
    Key key,
    @required this.child,
  }) : super(key: key);

  final ProjectDetailsModel child;

  @override
  _ProjectDetailsCardState createState() => _ProjectDetailsCardState();
}

class _ProjectDetailsCardState extends State<ProjectDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormatter = DateFormat('dd MMM yyyy');
    final String dateCreated = _dateFormatter.format(widget.child.dateCreated);
    final String dateDeadline =
        _dateFormatter.format(widget.child.dateDeadline);
    final String difference = widget.child.dateDeadline
        .difference(widget.child.dateCreated)
        .inDays
        .toString();
    final String daysRemaining =
        widget.child.dateDeadline.difference(DateTime.now()).inDays.toString();

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
                child: Text('Proyek ${widget.child.projectName}')),
            if (widget.child.projectId != null && widget.child.projectId != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('ID:  ${widget.child.projectId}')),
            if (widget.child.address != null && widget.child.address != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('${widget.child.address ?? '(Alamat kosong)'}')),
            if (widget.child.clientName != null &&
                widget.child.clientName != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                      '${widget.child.clientName} - ${widget.child.clientPhone ?? ''}')),
            if (widget.child.clientEmail != null &&
                widget.child.clientEmail != '')
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('${widget.child.clientEmail ?? ''}')),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text('$dateCreated - $dateDeadline ($difference hari)')),
            if (!widget.child.isCompleted)
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text('Tersisa $daysRemaining hari lagi')),
          ],
        ),
      ),
    );
  }
}
