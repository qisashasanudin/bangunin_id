import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:flutter/material.dart';

class ProjectMaterialForm extends StatefulWidget {
  const ProjectMaterialForm({
    Key key,
    @required this.children,
    this.onChangedType,
    this.onChangedAmount,
  }) : super(key: key);

  final List<String> children;
  final Function(String) onChangedType;
  final Function(String) onChangedAmount;

  @override
  _ProjectMaterialFormState createState() => _ProjectMaterialFormState();
}

class _ProjectMaterialFormState extends State<ProjectMaterialForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _materialType(),
          )),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _materialAmount(),
          )),
        ],
      ),
    );
  }

  DropdownButtonFormField _materialType() {
    return DropdownButtonFormField(
      items: widget.children.map((material) {
        return DropdownMenuItem(
          value: material,
          child: Text(material),
        );
      }).toList(),
      onChanged: (val) => setState(() {
        widget.onChangedType(val);
      }),
    );
  }

  TextFormField _materialAmount() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: formFieldDecoration('Jumlah material'),
      validator: (val) => (val.isEmpty) ? 'Tidak boleh kosong.' : null,
      onChanged: (val) => setState(() {
        widget.onChangedAmount(val);
      }),
    );
  }
}
