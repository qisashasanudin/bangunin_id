import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/project_material_form.dart';
import 'package:flutter/material.dart';

class DynamicMultiForm extends StatefulWidget {
  final Function(List<MaterialModel> newModelValue) callBack;

  DynamicMultiForm({Key key, this.callBack}) : super(key: key);

  @override
  _DynamicMultiFormState createState() => _DynamicMultiFormState();
}

class _DynamicMultiFormState extends State<DynamicMultiForm> {
  List<MaterialModel> unselectedMaterialsList = List.from(materials);
  List<MaterialModel> selectedMaterialsList = [];
  List<ProjectMaterialForm> materialsForm = [];

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        projectMaterialList(),
        addAndDeleteButton(),
      ],
    );
  }
  //========================= main function =========================

  ListView projectMaterialList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: materialsForm.length,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: materialsForm[index],
      ),
    );
  }

  Row addAndDeleteButton() {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: new DropdownButton(
              hint: Text('Tambah material'),
              items: [
                for (var materialType in unselectedMaterialsList)
                  new DropdownMenuItem(
                    value: materialType,
                    child: Text(
                        '${materialType.name ?? ''} ${materialType.size ?? ''} ${materialType.type ?? ''}'),
                  )
              ],
              onChanged: (value) {
                addNewMaterial(value);
              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton(
              prompt: 'Hapus',
              onPressed: deleteMaterial,
            ),
          ),
        ),
      ],
    );
  }

  void addNewMaterial(materialType) {
    if (materialsForm.length >= materials.length) {
      return;
    }
    setState(() {
      selectedMaterialsList.add(materialType);
      unselectedMaterialsList.removeWhere((element) => element == materialType);
      materialsForm.add(ProjectMaterialForm(
        callBack: getNewMaterialData,
        modelValue: materialType,
      ));
    });
  }

  void deleteMaterial() {
    if (materialsForm.length < 1) {
      return;
    }
    setState(() {
      unselectedMaterialsList.add(selectedMaterialsList.last);
      selectedMaterialsList.removeLast();
      materialsForm.removeLast();
    });
  }

  getNewMaterialData(MaterialModel newMaterialModel) {
    setState(() {
      selectedMaterialsList[selectedMaterialsList.indexWhere((element) =>
          element.name == newMaterialModel.name &&
          element.type == newMaterialModel.type &&
          element.size == newMaterialModel.size)] = newMaterialModel;
    });
    for (var element in selectedMaterialsList)
      print(
          '${element.name} ${element.size ?? ''} ${element.type ?? ''} ${element.amount ?? ''}');
    widget.callBack(selectedMaterialsList);
  }
}
