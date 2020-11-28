import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
import 'package:flutter/material.dart';

class ProjectMaterialsList extends StatefulWidget {
  @override
  _ProjectMaterialsListState createState() => _ProjectMaterialsListState();
}

class _ProjectMaterialsListState extends State<ProjectMaterialsList> {
  List<DynamicWidget> _dynamicList = [];

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _dynamicList.length,
            itemBuilder: (context, index) {
              return _dynamicList[index];
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _editMaterialListButton(
                  Text('+', style: TextStyle(fontSize: 25)), _addList),
              _editMaterialListButton(
                  Text('-', style: TextStyle(fontSize: 25)), _removeList),
            ],
          ),
        ],
      ),
    );
  }
  //========================= main function =========================

  Padding _editMaterialListButton(prompt, onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: RaisedButton(
        child: prompt,
        onPressed: onPressed,
      ),
    );
  }

  _addList() {
    _dynamicList.add(DynamicWidget());
    setState(() {});
  }

  _removeList() {
    _dynamicList.removeLast();
    setState(() {});
  }
}

class DynamicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _numberForm('Jenis material', false),
          )),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _numberForm('Jumlah material', false),
          )),
        ],
      ),
    );
  }
}

TextFormField _numberForm(labelText, mustBeFilled) {
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: formFieldDecoration(labelText),
    validator: (val) => (val.isEmpty && mustBeFilled == true)
        ? 'Data tidak boleh kosong.'
        : null,
    onChanged: (val) {},
  );
}
