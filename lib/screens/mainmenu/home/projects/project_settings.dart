import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/project_materials_list.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/popup_dialog.dart';
import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectSettings extends StatefulWidget {
  @override
  _ProjectSettingsState createState() => _ProjectSettingsState();
}

class _ProjectSettingsState extends State<ProjectSettings> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();

  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('dd MMM, yyyy');

  ProjectDetailsModel _projectDetails = ProjectDetailsModel(
    isCompleted: false,
  );

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
          //   'assets/img/new_project_bg.jpg',
          //   fit: BoxFit.cover,
          // ),
          title: Text('Proyek ${_projectDetails.projectName ?? 'Baru'}'),
          children: [
            SliverList(
              delegate: SliverChildListDelegate([
                sectionHeader('Informasi Utama (Wajib Diisi)'),
                _textForm('Nama Proyek', true),
                _dateForm('Deadline', true),
                separatorLine(),
                sectionHeader('Informasi Tambahan (Opsional)'),
                _textForm('Alamat', false),
                //TODO: BUAT OPSI UNTUK MENGISI ALAMAT DGN GOOGLE MAP
                _textForm('Nama Klien', false),
                _textForm('Email Klien', false),
                _textForm('Nomor Telepon Klien', false),
                separatorLine(),
                sectionHeader('Material Yang Dibutuhkan'),
                ProjectMaterialsList(),
                //TODO: Dropdown List yang jumlahnya bisa ditambahkan dan diberi angka
                separatorLine(),
                saveButton(),
              ]),
            ), //sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }
  //========================= main function =========================

  Future<bool> _onBackPressed() async {
    bool tappedYes = false;
    final action = await PopUpDialog.yesNoDialog(context, 'Keluar?',
        'Apakah anda yakin ingin keluar? Semua pengaturan pada halaman ini tidak akan tersimpan.');
    if (action == DialogAction.yes) {
      tappedYes = true;
    }
    return tappedYes;
  }

  Padding separatorLine() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Divider(color: Colors.black));
  }

  Padding sectionHeader(text) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Text(text));
  }

  SizedBox _textForm(labelText, mustBeFilled) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: TextFormField(
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
          decoration: formFieldDecoration(labelText),
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
      initialDate: _projectDetails.dateDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    setState(() {
      _projectDetails.dateDeadline = date;
    });
    _dateController.text = _dateFormatter.format(_projectDetails.dateDeadline);
  }

  Padding saveButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: customButton('Simpan', _uploadData));
  }

  void _uploadData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _projectDetails.dateCreated = DateTime.now();
      });
      await DatabaseService(uid: AuthService().getCurrentUID())
          .createDataOnSubcollection('accounts', 'projects', {
        'projectName': _projectDetails.projectName,
        'address': _projectDetails.address,
        'addressGMap': _projectDetails.addressGMap,
        'clientName': _projectDetails.clientName,
        'clientEmail': _projectDetails.clientEmail,
        'clientPhone': _projectDetails.clientPhone,
        'dateCreated': _projectDetails.dateCreated,
        'dateDeadline': _projectDetails.dateDeadline,
        'isCompleted': _projectDetails.isCompleted,
      });

      // await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
      //     'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.of(context).pop();
    }
  }
}
