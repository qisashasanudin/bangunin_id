import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:flutter/material.dart';

//TODO: gabungkan kedua jenis TextFormField

class CustomTextFormField extends StatefulWidget {
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
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
    onChanged: (val) {},
  );
}

TextFormField _editText(String attribute) {
  return TextFormField(
    keyboardType:
        (attribute == 'phone') ? TextInputType.number : TextInputType.text,
    // initialValue: currentValue,
    decoration: formFieldDecoration(attribute),
    validator: (val) => (val.isEmpty) ? 'Data tidak boleh kosong' : null,
    onChanged: (val) {},
  );
}
