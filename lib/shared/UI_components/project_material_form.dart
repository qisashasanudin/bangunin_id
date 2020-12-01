import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnDelete();

class ProjectMaterialForm extends StatefulWidget {
  final state = _ProjectMaterialFormState();
  final MaterialModel children;
  final Function(MaterialModel newObject) returnValue;

  ProjectMaterialForm({Key key, this.children, this.returnValue})
      : super(key: key);

  @override
  _ProjectMaterialFormState createState() => state;

  bool isValid() => state.validate();
}

class _ProjectMaterialFormState extends State<ProjectMaterialForm> {
  final _formKey = GlobalKey<FormState>();

  bool validate() {
    var valid = _formKey.currentState.validate();
    return valid;
  }

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shadowColor: Color(0x802196F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              materialType(),
              materialAmount(),
              materialUnit(),
            ],
          ),
        ),
      ),
    );
  }
  //========================= main function =========================

  Padding materialType() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
          '${widget.children.name} ${widget.children.size ?? ''} ${widget.children.type ?? ''}'),
    );
  }

  Flexible materialAmount() {
    return Flexible(
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: formFieldDecoration('Jumlah'),
        validator: (val) => (val.isEmpty) ? 'Data tidak boleh kosong.' : null,
        onChanged: (newValue) {
          widget.children.amount = int.parse(newValue);
          widget.returnValue(widget.children);
        },
      ),
    );
  }

  Padding materialUnit() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text('${widget.children.unit}'),
    );
  }
}
