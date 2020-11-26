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
  List<String> item = ['', '', '', ''];

  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('dd MMM, yyyy');

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

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
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child:
                        Text('Masukkan informasi dasar mengenai proyek ini.'),
                  ),
                  _textForm('Nama Proyek', true, 0),
                  _textForm('Alamat', false, 1),
                  //TODO: BUAT OPSI UNTUK MENGISI ALAMAT DGN GOOGLE MAP
                  _textForm('Email Client', false, 2),
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

  SizedBox _textForm(labelText, mustBeFilled, index) {
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
            setState(() => item[index] = val);
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
          style: TextStyle(fontSize: 18),
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
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(_date);
    }
  }

  void _uploadData() async {
    if (_formKey.currentState.validate()) {
      // await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
      //     'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.of(context).pushNamed('/newproject_materials');
    }
  }
}
