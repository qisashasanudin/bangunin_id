import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';

class ProjectReview extends StatefulWidget {
  @override
  _ProjectReviewState createState() => _ProjectReviewState();
}

class _ProjectReviewState extends State<ProjectReview> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    List<dynamic> input = ModalRoute.of(context).settings.arguments;

    return Form(
      key: _formKey,
      child: SliverPage(
        // backgroundImage: Image.asset(
        //   'assets/img/UI/new_project_bg.jpg',
        //   fit: BoxFit.cover,
        // ),
        title: Text('Review Proyek ${input[0].projectName ?? 'Baru'}'),
        children: [
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ProjectDetailsCard(child: input[0]),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withAlpha(50),
                      //color: Colors.grey.withAlpha(50),
                      offset: Offset(0, 0),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/img/UI/character.png'),
                            //NetworkImage(
                            //'https://i.pravatar.cc/11$index'),
                            minRadius: 35,
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Klien Bangunin ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(
                            'Bagaimana keadaannya ?',
                            style: TextStyle(
                              color: Color(0xFFFF9900),
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(
                            '1:00 AM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //widget-widget lain dipasang di sini
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CustomButton(
                    prompt: 'Simpan',
                    onPressed: () {
                      _uploadData(input[0], input[1]);
                    }),
              ),
            ]),
          ), //sliver-sliver lain ditulis di sini
        ],
      ),
    );
  }

  //========================= main function =========================

  _uploadData(ProjectDetailsModel projectDetails,
      List<MaterialModel> projectMaterials) async {
    if (_formKey.currentState.validate() && projectMaterials.isNotEmpty) {
      String docId = (projectDetails.projectId != null)
          ? projectDetails.projectId
          : await DatabaseService(
              uid: AuthService().getCurrentUID(),
            ).writeDoc(
              'accounts/$userID/projects/',
              {
                'projectName': projectDetails.projectName,
                'address': projectDetails.address,
                'addressGMap': projectDetails.addressGMap,
                'clientName': projectDetails.clientName,
                'clientEmail': projectDetails.clientEmail,
                'clientPhone': projectDetails.clientPhone,
                'dateCreated': projectDetails.dateCreated ?? DateTime.now(),
                'dateDeadline': projectDetails.dateDeadline,
                'isCompleted': projectDetails.isCompleted ?? false,
              },
            );
      //TODO: material yang dihapus belum bisa hilang dari database
      for (var element in projectMaterials) {
        await DatabaseService(
          uid: AuthService().getCurrentUID(),
          docId: element.materialId,
        ).writeDoc(
          'accounts/$userID/projects/$docId/materials_target',
          {
            'name': element.name,
            'size': element.size,
            'type': element.type,
            'unit': element.unit,
            'price': element.price,
            'amount': element.amount,
            'image': element.image,
          },
        );
      }
      Navigator.popUntil(context, ModalRoute.withName('/mainpage'));
    }
  }
}
