import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/input_box_border.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProject extends StatefulWidget {
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  final userID = AuthService().getCurrentUID();
  final _formKey = GlobalKey<FormState>();

  String _projectName;
  String _address;
  String _addressGMap;
  String _clientName;
  String _clientEmail;
  String _clientPhone;
  String _supervisorName;
  String _supervisorEmail;
  String _supervisorPhone;
  DateTime _dateCreated;
  DateTime _dateDeadline;
  bool _isCompleted = false;

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
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
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
                    child: _submitButton(snapshot, 'Selanjutnya'),
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
          keyboardType: (labelText == 'Nomor Telepon Klien')
              ? TextInputType.number
              : (labelText == 'Email Klien')
                  ? TextInputType.emailAddress
                  : TextInputType.text,
          decoration: inputBoxBorder(labelText),
          validator: (val) => (val.isEmpty && mustBeFilled == true)
              ? 'Data tidak boleh kosong.'
              : null,
          onChanged: (val) {
            setState(() {
              switch (labelText) {
                case 'Nama Proyek':
                  _projectName = val;
                  break;
                case 'Alamat':
                  _address = val;
                  break;
                case 'Nama Klien':
                  _clientName = val;
                  break;
                case 'Email Klien':
                  _clientEmail = val;
                  break;
                case 'Nomor Telepon Klien':
                  _clientPhone = val;
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
      initialDate: _dateDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    setState(() {
      _dateDeadline = date;
    });
    _dateController.text = _dateFormatter.format(_dateDeadline);
  }

  SizedBox _submitButton(snapshot, String prompt) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: AppColors().primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(prompt, style: TextStyle(color: AppColors().accent1)),
        onPressed: () async {
          _uploadData(snapshot);
        },
      ),
    );
  }

  void _uploadData(snapshot) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _supervisorName = snapshot.data.data()['name'];
        _supervisorEmail = snapshot.data.data()['email'];
        _supervisorPhone = snapshot.data.data()['phone'];
        _dateCreated = DateTime.now();
      });
      print(
          '$_projectName, $_address, $_addressGMap, $_clientName, $_clientEmail, $_clientPhone, $_supervisorName, $_supervisorEmail, $_supervisorPhone, $_dateCreated, $_dateDeadline, $_isCompleted');
      // await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
      //     'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      //Navigator.of(context).pushNamed('/newproject_materials');
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
