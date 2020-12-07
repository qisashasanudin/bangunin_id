import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm({
    Key key,
    this.initialValue,
    @required this.label,
    @required this.mustBeFilled,
    @required this.onChanged,
  }) : super(key: key);

  final String initialValue;
  final String label;
  final bool mustBeFilled;
  final Function(String) onChanged;

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          (widget.label == 'Nomor Telepon Klien' || widget.label == 'phone')
              ? TextInputType.number
              : (widget.label == 'Email Klien')
                  ? TextInputType.emailAddress
                  : TextInputType.text,
      inputFormatters: [
        if (widget.label == 'Nomor Telepon Klien' || widget.label == 'phone')
          FilteringTextInputFormatter.digitsOnly,
      ],
      initialValue: widget.initialValue,
      decoration: formFieldDecoration(widget.label),
      validator: (val) => (val.isEmpty && widget.mustBeFilled == true)
          ? 'Data tidak boleh kosong.'
          : null,
      onChanged: (val) {
        widget.onChanged(val);
      },
    );
  }
}
