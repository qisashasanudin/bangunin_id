import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/custom_text_form.dart';
import 'package:bangunin_id/shared/UI_components/on_back_pressed.dart';
import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectInformation extends StatefulWidget {
  @override
  _ProjectInformationState createState() => _ProjectInformationState();
}

class _ProjectInformationState extends State<ProjectInformation> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();

  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('dd MMM yyyy');
  ProjectDetailsModel _projectDetails = ProjectDetailsModel();
  bool loaded = false;

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    ProjectDetailsModel currentValue =
        ModalRoute.of(context).settings.arguments ?? ProjectDetailsModel();

    if (currentValue.projectId != null && loaded == false) {
      _projectDetails = currentValue;
      _dateController.text =
          _dateFormatter.format(_projectDetails.dateDeadline ?? DateTime.now());
      loaded = true;
    }

    return WillPopScope(
      onWillPop: () async => await onBackPressed(context),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text('Informasi Utama (Wajib Diisi)')),
                _projectNameForm(),
                _deadlineForm(),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Divider(color: Colors.black)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text('Informasi Tambahan (Opsional)')),
                _addressForm(),
                //TODO: BUAT OPSI UNTUK MENGISI ALAMAT DGN GOOGLE MAP
                _clientNameForm(),
                _clientEmailForm(),
                _clientPhoneForm(),
                SizedBox(height: 70),
              ]),
            ),
            //sliver-sliver lain ditulis di sini
          ],
          floatingActionButton: _nextButton(),
        ),
      ),
    );
  }
  //========================= main function =========================

  Padding _projectNameForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Nama Proyek',
          mustBeFilled: true,
          initialValue: _projectDetails.projectName,
          onChanged: (val) {
            _chooseProjectDetailsElement('Nama Proyek', val);
          },
        ));
  }

  Padding _deadlineForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          readOnly: true,
          controller: _dateController,
          onTap: _handleDatePicker,
          decoration: formFieldDecoration('Deadline'),
          validator: (val) => (val.isEmpty) ? 'Data tidak boleh kosong.' : null,
        ));
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

  Padding _addressForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Alamat',
          mustBeFilled: false,
          initialValue: _projectDetails.address,
          onChanged: (val) {
            _chooseProjectDetailsElement('Alamat', val);
          },
        ));
  }

  Padding _clientNameForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Nama Klien',
          mustBeFilled: false,
          initialValue: _projectDetails.clientName,
          onChanged: (val) {
            _chooseProjectDetailsElement('Nama Klien', val);
          },
        ));
  }

  Padding _clientEmailForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Email Klien',
          mustBeFilled: false,
          initialValue: _projectDetails.clientEmail,
          onChanged: (val) {
            _chooseProjectDetailsElement('Email Klien', val);
          },
        ));
  }

  Padding _clientPhoneForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Nomor Telepon Klien',
          mustBeFilled: false,
          initialValue: _projectDetails.clientPhone,
          onChanged: (val) {
            _chooseProjectDetailsElement('Nomor Telepon Klien', val);
          },
        ));
  }

  void _chooseProjectDetailsElement(String labelText, String val) {
    return setState(() {
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
  }

  FloatingActionButton _nextButton() {
    return FloatingActionButton.extended(
      elevation: 10,
      backgroundColor: Theme.of(context).primaryColor,
      label: Text(
          (_projectDetails.projectId != null) ? 'Simpan' : 'Selanjutnya',
          style: TextStyle(color: AppColors().accent1)),
      onPressed: (_projectDetails.projectId == null)
          ? _moveToNewProjectBoQ
          : () => _saveChanges(),
    );
  }

  _moveToNewProjectBoQ() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _projectDetails.dateCreated = DateTime.now();
        _projectDetails.isCompleted = false;
      });
      Navigator.of(context).pushNamed(
        '/projectBoQ',
        arguments: _projectDetails,
      );
    }
  }

  _saveChanges() async {
    if (_formKey.currentState.validate()) {
      await DatabaseService(
              uid: AuthService().getCurrentUID(),
              docId: _projectDetails.projectId)
          .writeDoc(
        'accounts/$userID/projects/',
        {
          'projectName': _projectDetails.projectName,
          'address': _projectDetails.address,
          'addressGMap': _projectDetails.addressGMap,
          'clientName': _projectDetails.clientName,
          'clientEmail': _projectDetails.clientEmail,
          'clientPhone': _projectDetails.clientPhone,
          'dateCreated': _projectDetails.dateCreated,
          'dateDeadline': _projectDetails.dateDeadline,
          'isCompleted': _projectDetails.isCompleted,
        },
      );
      Navigator.popUntil(context, ModalRoute.withName('/mainpage'));
    }
  }
}
