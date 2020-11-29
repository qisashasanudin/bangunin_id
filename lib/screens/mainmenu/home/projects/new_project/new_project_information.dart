import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/popup_dialog.dart';
import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProjectInformation extends StatefulWidget {
  @override
  _NewProjectInformationState createState() => _NewProjectInformationState();
}

class _NewProjectInformationState extends State<NewProjectInformation> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();

  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('dd MMM, yyyy');
  ProjectDetailsModel _projectDetails = ProjectDetailsModel();

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Form(
        key: _formKey,
        child: SliverPage(
          // backgroundImage: Image.asset(
          //   'assets/img/UI/new_project_bg.jpg',
          //   fit: BoxFit.cover,
          // ),
          title: Text('Proyek ${_projectDetails.projectName ?? 'Baru'}'),
          children: [
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text('Informasi Utama (Wajib Diisi)')),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: _textForm('Nama Proyek', true)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: _dateForm('Deadline', true)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Divider(color: Colors.black)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text('Informasi Tambahan (Opsional)')),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: _textForm('Alamat', false)),
                //TODO: BUAT OPSI UNTUK MENGISI ALAMAT DGN GOOGLE MAP
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: _textForm('Nama Klien', false)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: _textForm('Email Klien', false)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: _textForm('Nomor Telepon Klien', false)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: customButton(
                        'Selanjutnya', _moveToNewProjectMaterials)),
              ]),
            ),
            //sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }

  //========================= main function =========================

  Future<bool> _onBackPressed() async {
    bool tappedYes = false;
    final action = await PopUpDialog.yesNoDialog(context, 'Kembali?',
        'Apakah anda yakin ingin kembali? Semua pengaturan pada halaman ini tidak akan tersimpan.');
    if (action == DialogAction.yes) {
      tappedYes = true;
    }
    return tappedYes;
  }

  TextFormField _textForm(labelText, mustBeFilled) {
    return TextFormField(
      keyboardType: (labelText == 'Nomor Telepon Klien')
          ? TextInputType.number
          : (labelText == 'Email Klien')
              ? TextInputType.emailAddress
              : TextInputType.text,
      decoration: formFieldDecoration(labelText),
      validator: (val) => (val.isEmpty && mustBeFilled == true)
          ? 'Data tidak boleh kosong.'
          : null,
      onChanged: (val) {
        setState(() {
          switch (labelText) {
            case 'Nama Proyek':
              _projectDetails.projectName = val;
              break;
            case 'Alamat':
              _projectDetails.address = val;
              break;
            case 'Nama Klien':
              _projectDetails.clientName = val;
              break;
            case 'Email Klien':
              _projectDetails.clientEmail = val;
              break;
            case 'Nomor Telepon Klien':
              _projectDetails.clientPhone = val;
              break;
          }
        });
      },
    );
  }

  TextFormField _dateForm(labelText, mustBeFilled) {
    return TextFormField(
      readOnly: true,
      controller: _dateController,
      onTap: _handleDatePicker,
      decoration: formFieldDecoration(labelText),
      validator: (val) => (val.isEmpty && mustBeFilled == true)
          ? 'Data tidak boleh kosong.'
          : null,
    );
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _projectDetails.dateDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    setState(() {
      _projectDetails.dateDeadline = date;
    });
    _dateController.text = _dateFormatter.format(_projectDetails.dateDeadline);
  }

  void _moveToNewProjectMaterials() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _projectDetails.dateCreated = DateTime.now();
        _projectDetails.isCompleted = false;
      });
      //TODO: upload materials information
      // await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
      //     'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.of(context).pushNamed(
        '/newprojectmaterials',
        arguments: _projectDetails,
      );
    }
  }
}
