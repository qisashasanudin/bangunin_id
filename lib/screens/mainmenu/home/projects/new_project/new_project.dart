import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/UI_templates.dart';
import 'package:bangunin_id/shared/sliver_page.dart';
import 'package:flutter/material.dart';

class NewProject extends StatefulWidget {
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  final _formKey = GlobalKey<FormState>();
  List<String> item = ['', '', '', ''];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return Form(
          key: _formKey,
          child: SliverPage(
            children: [
              SliverAppBar(
                stretch: true,
                pinned: true,
                expandedHeight: screenHeight / 4,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Buat Proyek Baru'),
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child:
                        Text('Masukkan informasi dasar mengenai proyek ini.'),
                  ),
                  _textForm('Nama Proyek', true, 0),
                  _textForm('Alamat', false, 1),
                  //TODO: BUAT OPSI UNTUK MENGISI ALAMAT DGN GOOGLE MAP
                  _textForm('Email Client', false, 2),
                  //TODO: BUAT FORM DEADLINE (TANGGAL)
                  _submitButton(snapshot, 'Selanjutnya'),
                ]),
              ), //sliver-sliver lain ditulis di sini
            ],
          ),
        );
      },
    );
  }

  SizedBox _textForm(hintText, mustBeFilled, index) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                hintText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              decoration: inputBoxBorder().copyWith(hintText: hintText),
              validator: (val) => (val.isEmpty && mustBeFilled == true)
                  ? 'Data tidak boleh kosong.'
                  : null,
              onChanged: (val) {
                setState(() => item[index] = val);
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding _submitButton(snapshot, String prompt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: RaisedButton(
        color: AppColors().primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(prompt, style: TextStyle(color: AppColors().accent1)),
        onPressed: () async {
          _uploadData(snapshot, item, item);
        },
      ),
    );
  }

  void _uploadData(snapshot, attribute, data) async {
    if (_formKey.currentState.validate()) {
      // await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
      //     'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.of(context).pushNamed('/newproject_materials');
    }
  }
}
