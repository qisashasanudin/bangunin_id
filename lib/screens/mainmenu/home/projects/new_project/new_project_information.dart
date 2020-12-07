import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/custom_text_form.dart';
import 'package:bangunin_id/shared/UI_components/on_back_pressed.dart';
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
                _nextButton(),
              ]),
            ),
            //sliver-sliver lain ditulis di sini
          ],
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
          onChanged: (val) {
            _chooseProjectDetailsElement('Nama Proyek', val);
          },
        ));
  }

  Padding _deadlineForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: _dateForm('Deadline', true));
  }

  Padding _addressForm() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomTextForm(
          label: 'Alamat',
          mustBeFilled: false,
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
          onChanged: (val) {
            _chooseProjectDetailsElement('Nomor Telepon Klien', val);
          },
        ));
  }

  Padding _nextButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomButton(
          prompt: 'Selanjutnya',
          onPressed: _moveToNewProjectMaterials,
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

  _moveToNewProjectMaterials() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _projectDetails.dateCreated = DateTime.now();
        _projectDetails.isCompleted = false;
      });
      Navigator.of(context).pushNamed(
        '/newprojectmaterials',
        arguments: _projectDetails,
      );
    }
  }
}
