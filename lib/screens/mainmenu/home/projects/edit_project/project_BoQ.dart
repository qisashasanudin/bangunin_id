import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';

class ProjectBoQ extends StatefulWidget {
  @override
  _ProjectBoQState createState() => _ProjectBoQState();
}

class _ProjectBoQState extends State<ProjectBoQ> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    ProjectDetailsModel input = ModalRoute.of(context).settings.arguments;

    return Form(
      key: _formKey,
      child: SliverPage(
        // backgroundImage: Image.asset(
        //   'assets/img/UI/new_project_bg.jpg',
        //   fit: BoxFit.cover,
        // ),
        title: Text('BoQ Proyek ${input.projectName ?? 'Baru'}'),
        children: [
          SliverList(
            delegate: SliverChildListDelegate([
              //widget-widget lain dipasang di sini
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ProjectDetailsCard(child: input),
              ),
              _nextButton(input),
            ]),
          ), //sliver-sliver lain ditulis di sini
        ],
      ),
    );
  }

  //========================= main function =========================
  Padding _nextButton(ProjectDetailsModel input) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomButton(
          prompt: 'Selanjutnya',
          onPressed: () {
            _moveToNewProjectMaterials(input);
          },
        ));
  }

  _moveToNewProjectMaterials(ProjectDetailsModel input) {
    if (_formKey.currentState.validate()) {
      setState(() {
        input.dateCreated = DateTime.now();
        input.isCompleted = false;
      });
      Navigator.of(context).pushNamed(
        '/projectmaterials',
        arguments: [input],
      );
    }
  }
}
