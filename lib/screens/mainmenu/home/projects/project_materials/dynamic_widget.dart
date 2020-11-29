import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:flutter/material.dart';

class DynamicWidget extends StatefulWidget {
  @override
  _DynamicWidgetState createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  // List<DropdownMenuItem<String>> dropDownItems = List();

  final List<String> materials = ['Kasir', 'Keramik', 'BatuBata'];

  String _choosenMaterialType;
  String _choosenMaterialAmount;

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
      value: _choosenMaterialType ?? materials[0],
      items: materials.map((material) {
        return DropdownMenuItem(
          value: material,
          child: Text(material),
        );
      }).toList(),
      onChanged: (val) => setState(() => _choosenMaterialType = val),
    );
  }

  TextFormField _materialAmount() {
    return TextFormField(
      initialValue: _choosenMaterialAmount,
      keyboardType: TextInputType.number,
      decoration: formFieldDecoration('Jumlah material'),
      validator: (val) => (val.isEmpty) ? 'Tidak boleh kosong.' : null,
      onChanged: (val) => setState(() => _choosenMaterialAmount = val),
    );
  }
}
