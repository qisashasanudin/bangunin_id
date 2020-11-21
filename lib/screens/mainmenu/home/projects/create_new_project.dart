import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/decorations.dart';
import 'package:bangunin_id/shared/sliver_page.dart';
import 'package:flutter/material.dart';

class CreateNewProject extends StatefulWidget {
  @override
  _CreateNewProjectState createState() => _CreateNewProjectState();
}

List<String> item = ['', '', '', '', ''];

class _CreateNewProjectState extends State<CreateNewProject> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return SliverPage(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text('Masukkan angka sesuai dengan kebutuhan.'),
                ),
                itemForm('Nama Proyek', 0),
                itemForm('Pasir', 1),
                itemForm('Keramik', 2),
                itemForm('Batu Bata', 3),
                itemForm('Semen', 4),
                submitButton(snapshot, 'Simpan'),
              ]),
            ), //sliver-sliver lain ditulis di sini
          ],
        );
      },
    );
  }

  Padding itemForm(hintText, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        decoration: inputBoxBorder().copyWith(hintText: hintText),
        validator: (val) => (val.isEmpty) ? 'Data tidak boleh kosong.' : null,
        onChanged: (val) {
          setState(() => item[index] = val);
        },
      ),
    );
  }

  Padding submitButton(snapshot, String prompt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: RaisedButton(
        color: AppColors().primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(prompt, style: TextStyle(color: AppColors().accent1)),
        onPressed: () async {
          // uploadData(snapshot, attribute, item);
        },
      ),
    );
  }

  // void uploadData(snapshot, attribute, dataList) async {
  //   if (_formKey.currentState.validate()) {
  //     await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
  //         'projects', attribute, dataList ?? snapshot.data.data()[attribute]);
  //     Navigator.pop(context);
  //   }
  // }
}
