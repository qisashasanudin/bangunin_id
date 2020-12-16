import 'package:bangunin_id/models/BoQ_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/custom_text_form.dart';
import 'package:bangunin_id/shared/UI_components/on_back_pressed.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/shared/UI_components/custom_heading.dart';

class ProjectBoQ extends StatefulWidget {
  @override
  _ProjectBoQState createState() => _ProjectBoQState();
}

class _ProjectBoQState extends State<ProjectBoQ> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();
  final currentBoQDataset = List.from(boqDataset);

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    ProjectDetailsModel input = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async => await onBackPressed(context),
      child: Form(
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
                  //child: ProjectDetailsCard(child: input),
                  child: CustomHeading(
                    title:
                        'Rincian Anggaran Biaya \nPekerjaan Pembangunan Rumah',
                  ),
                ),
                DefaultTabController(
                  length: currentBoQDataset.length,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        unselectedLabelColor: Colors.grey,
                        unselectedLabelStyle: TextStyle(fontSize: 16),
                        tabs: <Widget>[
                          for (var element in currentBoQDataset)
                            Tab(child: Text(element.categoryName)),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                          children: [
                            for (var element in currentBoQDataset)
                              ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  _tabledetail(),
                                  for (var item in element.contents)
                                    (item.unit != 'judul')
                                        ? _formFill(item)
                                        : _judul(item.name),
                                ],
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ), //sliver-sliver lain ditulis di sini
          ],
          floatingActionButton: _nextButton(input),
        ),
      ),
    );
  }
  //========================= main function =========================

  Padding _judul(String judul) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          judul,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  FloatingActionButton _nextButton(ProjectDetailsModel input) {
    return FloatingActionButton.extended(
      elevation: 10,
      backgroundColor: Theme.of(context).primaryColor,
      label: Text('Selanjutnya', style: TextStyle(color: AppColors().accent1)),
      onPressed: () {
        _moveToNewProjectMaterials(input);
      },
    );
  }

  Padding _formFill(BoQModel item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                item.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: CustomTextForm(
                label: null,
                mustBeFilled: false,
                onChanged: (val) {
                  setState(() {
                    item.amount = int.parse(val);
                  });
                }),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item.unit,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _tabledetail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        color: Colors.orangeAccent,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'NO  Detail Pekerjaan',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              'Jumlah',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              'Unit',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
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
