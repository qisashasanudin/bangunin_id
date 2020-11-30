import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/project_material_form.dart';
import 'package:flutter/material.dart';

class DynamicMultiForm extends StatefulWidget {
  @override
  _DynamicMultiFormState createState() => _DynamicMultiFormState();
}

class _DynamicMultiFormState extends State<DynamicMultiForm> {
  List<ProjectMaterialForm> materialsList = [];

  @override
  void initState() {
    // TODO: implement initState
    addMaterial();
    super.initState();
  }

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text('Tambahkan material dengan menekan tombol "+"')),
        projectMaterialList(),
        addAndDeleteMaterialButton(),
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
      itemCount: materialsList.length,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: materialsList[index],
      ),
    );
  }

  Row addAndDeleteMaterialButton() {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton(
              prompt: '+',
              onPressed: addMaterial,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton(
              prompt: '-',
              onPressed: deleteMaterial,
            ),
          ),
        ),
      ],
    );
  }

  void addMaterial() {
    if (materialsList.length >= materials.length) {
      return;
    }
    setState(() {
      materialsList.add(ProjectMaterialForm(
        model: MaterialModel(),
        modelValue: materials[materialsList.length],
      ));
    });
  }

  void deleteMaterial() {
    if (materialsList.length <= 1) {
      return;
    }
    setState(() {
      materialsList.removeLast();
    });
  }
}
