import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/custom_text_form.dart';
import 'package:bangunin_id/shared/UI_components/on_back_pressed.dart';
import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
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
                _projectNameForm(currentValue.projectName),
                _deadlineForm(currentValue.dateDeadline),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Divider(color: Colors.black)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text('Informasi Tambahan (Opsional)')),
                _addressForm(currentValue.address),
                //TODO: BUAT OPSI UNTUK MENGISI ALAMAT DGN GOOGLE MAP
                _clientNameForm(currentValue.clientName),
                _clientEmailForm(currentValue.clientEmail),
                _clientPhoneForm(currentValue.clientPhone),
                _nextButton(currentValue),
              ]),
            ),
            //sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }
  //========================= main function =========================

  Padding _projectNameForm(String currentVal) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Nama Proyek',
          mustBeFilled: true,
          initialValue: currentVal,
          onChanged: (val) {
            _chooseProjectDetailsElement('Nama Proyek', val);
          },
        ));
  }

  Padding _deadlineForm(DateTime currentVal) {
    if (currentVal != null)
      _dateController.text = _dateFormatter.format(currentVal);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          readOnly: true,
          controller: _dateController,
          onTap: () => _handleDatePicker(currentVal),
          decoration: formFieldDecoration('Deadline'),
          validator: (val) => (val.isEmpty) ? 'Data tidak boleh kosong.' : null,
        ));
  }

  _handleDatePicker(DateTime currentVal) async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: currentVal ?? _projectDetails.dateDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    setState(() {
      _projectDetails.dateDeadline = date;
    });
    _dateController.text = _dateFormatter.format(_projectDetails.dateDeadline);
  }

  Padding _addressForm(String currentVal) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Alamat',
          mustBeFilled: false,
          initialValue: currentVal,
          onChanged: (val) {
            _chooseProjectDetailsElement('Alamat', val);
          },
        ));
  }

  Padding _clientNameForm(String currentVal) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Nama Klien',
          mustBeFilled: false,
          initialValue: currentVal,
          onChanged: (val) {
            _chooseProjectDetailsElement('Nama Klien', val);
          },
        ));
  }

  Padding _clientEmailForm(String currentVal) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Email Klien',
          mustBeFilled: false,
          initialValue: currentVal,
          onChanged: (val) {
            _chooseProjectDetailsElement('Email Klien', val);
          },
        ));
  }

  Padding _clientPhoneForm(String currentVal) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Nomor Telepon Klien',
          mustBeFilled: false,
          initialValue: currentVal,
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

  Padding _nextButton(ProjectDetailsModel currentModel) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomButton(
          prompt: 'Selanjutnya',
          onPressed: (currentModel.projectId == null)
              ? _moveToNewProjectMaterials
              : () => _saveChanges(currentModel),
        ));
  }

  _moveToNewProjectMaterials() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _projectDetails.dateCreated = DateTime.now();
        _projectDetails.isCompleted = false;
      });
      Navigator.of(context).pushNamed(
        '/projectmaterials',
        arguments: _projectDetails,
      );
    }
  }

  _saveChanges(ProjectDetailsModel currentModel) async {
    if (_formKey.currentState.validate()) {
      await DatabaseService(
              uid: AuthService().getCurrentUID(),
              projectId: currentModel.projectId)
          .writeProjectData(
        {
          'projectName':
              _projectDetails.projectName ?? currentModel.projectName,
          'address': _projectDetails.address ?? currentModel.address,
          'addressGMap':
              _projectDetails.addressGMap ?? currentModel.addressGMap,
          'clientName': _projectDetails.clientName ?? currentModel.clientName,
          'clientEmail':
              _projectDetails.clientEmail ?? currentModel.clientEmail,
          'clientPhone':
              _projectDetails.clientPhone ?? currentModel.clientPhone,
          'dateCreated':
              _projectDetails.dateCreated ?? currentModel.dateCreated,
          'dateDeadline':
              _projectDetails.dateDeadline ?? currentModel.dateDeadline,
          'isCompleted':
              _projectDetails.isCompleted ?? currentModel.isCompleted,
        },
      );
      Navigator.of(context).pop();
    }
  }
}
