import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/project_material_form.dart';
import 'package:flutter/material.dart';

class DynamicMultiForm extends StatefulWidget {
  @override
  _DynamicMultiFormState createState() => _DynamicMultiFormState();
}

class _DynamicMultiFormState extends State<DynamicMultiForm> {
  List<MaterialModel> materialsList = List.from(materials);
  List<MaterialModel> choosenMaterialsList = [];
  List<ProjectMaterialForm> choosenMaterialsForm = [];

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
      itemCount: choosenMaterialsForm.length,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: choosenMaterialsForm[index],
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
                for (var materialType in materialsList)
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
            // CustomButton(
            //   prompt: '+',
            //   onPressed: addNewMaterial,
            // ),
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
    if (choosenMaterialsForm.length >= materials.length) {
      return;
    }
    setState(() {
      choosenMaterialsList.add(materialType);
      materialsList.removeWhere((element) => element == materialType);
      choosenMaterialsForm.add(ProjectMaterialForm(
        model: MaterialModel(),
        modelValue: materialType,
      ));
    });
  }

  void deleteMaterial() {
    if (choosenMaterialsForm.length < 1) {
      return;
    }
    setState(() {
      materialsList.add(choosenMaterialsList.last);
      choosenMaterialsList.removeLast();
      choosenMaterialsForm.removeLast();
    });
  }
}

// void addNewMaterial(materialType) {
//   if (choosenMaterialsForm.length >= materials.length) {
//     return;
//   }
//   setState(() {
//     choosenMaterialsForm.add(ProjectMaterialForm(
//       model: MaterialModel(),
//       modelValue: materialType,
//     ));
//     materialsList.removeWhere((element) =>
//         element.name == materialType.name &&
//         element.type == materialType.type &&
//         element.size == materialType.size);
//   });
// }

// void deleteMaterial() {
//   if (choosenMaterialsForm.length < 1) {
//     return;
//   }
//   setState(() {
//     choosenMaterialsForm.removeLast();
//   });
// }
