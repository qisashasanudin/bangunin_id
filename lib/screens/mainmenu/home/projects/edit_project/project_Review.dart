import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:bangunin_id/shared/UI_components/custom_heading.dart';
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
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: ProjectDetailsCard(child: input[0]),
              // ),
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
                                AssetImage('assets/img/UI/logo.jpg'),
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
                            'Rekapitulasi Akhir ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(
                            'Pemilik Rumah : Ibu Dewi',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(
                            'No. Penawaran: 03/PNW/BANGUNIN/IV/2020',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
                color: Colors.orange[300],
                thickness: 20,
                indent: 15,
                endIndent: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomHeading(
                    title: 'Detail Pekerjaan',
                  ),
                  Padding(
                    child: Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                  ),
                ],
              ),
              Divider(),
              _checkout1line('Rp. 150.000,00', '01.1   PEKERJAAN PERSIAPAN'),

              _checkoutSummary('01.2   STRUKTUR', 'Rp. 100.000,00',
                  '      I: Pekerjaan Struktur'),
              _checkoutSummary('01.3   PEKERJAAN DINDING', 'Rp. 20.000,00',
                  '      I: Pekerjaan Dinding Lantai 1'),
              _checkoutSummary('01.4   PEK. LANTAI,PLAFON DAN JENDELA PINTU',
                  'Rp. 250.000,00', '      I: Arsitek Lantai 1'),
              _checkoutSummary('01.5   PEKERJAAN TOILET', 'Rp. 390.000,00',
                  '      I: Pekerjaan Toilet LT 1(2 Ruang)'),
              _checkout1line('Rp. 150.000,00', '01.7 PEKERJAAN ATAP'),
              _checkout1line('Rp. 150.000,00', '01.8 PEKERJAAN PLUMBING'),
              _checkout1line('Rp. 150.000,00', '01.9 PEKERJAAN LISTRIK'),
              _checkout1line('Rp. 150.000,00', '01.13 PEKERJAAN LAIN-LAIN'),
              _checkouttotal('       Rp. 4.900.000,00', 'SUB TOTAL'),
              _checkouttotal(
                  '       Rp. 3.670.000,00', 'TOTAL PEMBULATAN + DISKON'),
              Divider(
                height: 50,
              ),
              _checkout1line(
                'Diajukan Oleh: Erlan Saputra Yudha\n                   Di Setujui Oleh: Ibu Dewi',
                'Jakarta Selatan\n4 Desember 2020',
              ),
              Divider(
                height: 20,
                color: Colors.white,
              ),
              _checkouttotal('       100.00', 'Luas Bangunan'),
              _checkouttotal('       Rp0', 'Harga Satuan /m2'),
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

  Container _checkoutSummary(String judul, String harga, String subtext) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  judul,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    subtext,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    harga,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Container _checkout1line(String harga, String subtext) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    subtext,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    harga,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Container _checkouttotal(String harga, String subtext) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    subtext,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    harga,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
