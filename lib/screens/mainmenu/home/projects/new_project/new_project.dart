import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/input_box_border.dart';
import 'package:bangunin_id/shared/UI_components/submit_button.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProject extends StatefulWidget {
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  final _formKey = GlobalKey<FormState>();

  String projectName;
  String address;
  String clientName;
  String clientEmail;
  String clientPhone;
  String supervisorName;
  String supervisorEmail;
  String supervisorPhone;
  DateTime dateCreated = DateTime.now();
  DateTime dateDeadline;
  bool isCompleted = false;

  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('dd MMM, yyyy');

  @override
  void initState() {
    // TODO: isi semua variabel supervisor
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return Form(
          key: _formKey,
          child: SliverPage(
            // backgroundImage: Image.asset(
            //   'assets/img/new_project_bg.jpg',
            //   fit: BoxFit.cover,
            // ),
            title: Text('Proyek Baru'),
            children: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Text(
                        'Masukkan informasi dasar mengenai proyek yang akan dibuat.'),
                  ),
                  _textForm('Nama Proyek', true),

                  _textForm('Alamat', false),
                  //TODO: BUAT OPSI UNTUK MENGISI ALAMAT DGN GOOGLE MAP
                  _textForm('Nama Klien', false),
                  _textForm('Email Klien', false),
                  _textForm('Nomor Telepon Klien', false),
                  _dateForm('Deadline', true),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: submitButton('Selanjutnya', _uploadData),
                  ),
                ]),
              ), //sliver-sliver lain ditulis di sini
            ],
          ),
        );
      },
    );
  }

  SizedBox _textForm(labelText, mustBeFilled) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: TextFormField(
          decoration: inputBoxBorder(labelText),
          validator: (val) => (val.isEmpty && mustBeFilled == true)
              ? 'Data tidak boleh kosong.'
              : null,
          onChanged: (val) {
            setState(() {
              switch (labelText) {
                case 'Nama Proyek':
                  projectName = val;
                  break;
                case 'Alamat':
                  address = val;
                  break;
                case 'Nama Klien':
                  clientName = val;
                  break;
                case 'Email Klien':
                  clientEmail = val;
                  break;
                case 'Nomor Telepon Klien':
                  clientPhone = val;
                  break;
              }
            });
          },
        ),
      ),
    );
  }

  SizedBox _dateForm(labelText, mustBeFilled) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: TextFormField(
          readOnly: true,
          controller: _dateController,
          onTap: _handleDatePicker,
          decoration: inputBoxBorder(labelText),
          validator: (val) => (val.isEmpty && mustBeFilled == true)
              ? 'Data tidak boleh kosong.'
              : null,
        ),
      ),
    );
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null && date != dateDeadline) {
      setState(() {
        dateDeadline = date;
      });
      _dateController.text = _dateFormatter.format(dateDeadline);
    }
  }

  void _uploadData() async {
    if (_formKey.currentState.validate()) {
      // await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
      //     'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.of(context).pushNamed('/newproject_materials');
    }
  }

  // void uploadData() async {
  //   if (_formKey.currentState.validate()) {
  //     String result = await _auth.signUpWithEmail(email, name, password);
  //     setState(() {
  //       error = result;
  //     });
  //     Navigator.of(context).pushNamed('/newproject_materials');
  //   }
  // }

}
