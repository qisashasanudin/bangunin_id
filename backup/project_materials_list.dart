import 'package:bangunin_id/screens/mainmenu/home/projects/project_materials/project_material_form.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:flutter/material.dart';

class ProjectMaterialsList extends StatefulWidget {
  @override
  _ProjectMaterialsListState createState() => _ProjectMaterialsListState();
}

class _ProjectMaterialsListState extends State<ProjectMaterialsList> {
  List<String> materials = [
    'Pasir',
    'Keramik',
    'BatuBata',
    'Semen',
    'Cat',
    'Kayu',
  ];
  List<ProjectMaterialForm> _dynamicMaterialList = [];
  String _chosenMaterialType;
  String _chosenMaterialAmount;

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _dynamicMaterialList.length,
            itemBuilder: (context, index) {
              return _dynamicMaterialList[index];
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: customButton('+', _addList),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: customButton('-', _removeList),
              ),
            ],
          ),
        ],
      ),
    );
  }
  //========================= main function =========================

  _addList() {
    if (_dynamicMaterialList.length >= materials.length) {
      return;
    }
    List<String> temp = List.from(materials);
    //TODO: hapus elemen yang telah dipilih di dropdown sebelumnya
    _dynamicMaterialList.add(ProjectMaterialForm(
      children: temp,
      onChangedType: (val) => _chosenMaterialType = val,
      onChangedAmount: (val) => _chosenMaterialAmount = val,
    ));
    setState(() {});
  }

  _removeList() {
    if (_dynamicMaterialList.length < 1) {
      return;
    }

    _dynamicMaterialList.removeLast();
    setState(() {});
  }
}
