import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/project_material_form.dart';
import 'package:flutter/material.dart';

class DynamicList extends StatefulWidget {
  final Function(List<MaterialModel> newModelValue) returnValue;

  DynamicList({Key key, this.returnValue}) : super(key: key);

  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  List<MaterialModel> unselectedObjects = List.from(materials);
  List<MaterialModel> selectedObjects = [];
  List<ProjectMaterialForm> generatedList = [];

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _list(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _addObjectButton(),
            _deleteObjectButton(),
          ],
        ),
      ],
    );
  }
  //========================= main function =========================

  ListView _list() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: generatedList.length,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: generatedList[index],
      ),
    );
  }

  Flexible _addObjectButton() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new DropdownButton(
          hint: Text('Tambah material'),
          items: [
            for (var object in unselectedObjects)
              new DropdownMenuItem(
                value: object,
                child: Text(
                    '${object.name ?? ''} ${object.size ?? ''} ${object.type ?? ''}'),
              )
          ],
          onChanged: (value) {
            _addObject(value);
          },
        ),
      ),
    );
  }

  void _addObject(object) {
    if (unselectedObjects.isEmpty) {
      return;
    }
    setState(() {
      selectedObjects.add(object);
      unselectedObjects.removeWhere((element) => element == object);
      generatedList.add(ProjectMaterialForm(
        children: object,
        returnValue: _getNewObject,
      ));
    });
  }

  Flexible _deleteObjectButton() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
          prompt: 'Hapus',
          onPressed: _deleteObject,
        ),
      ),
    );
  }

  void _deleteObject() {
    if (selectedObjects.isEmpty) {
      return;
    }
    setState(() {
      unselectedObjects.add(selectedObjects.last);
      selectedObjects.removeLast();
      generatedList.removeLast();
    });
  }

  _getNewObject(MaterialModel newObject) {
    setState(() {
      selectedObjects[selectedObjects.indexWhere((oldObject) =>
          oldObject.name == newObject.name &&
          oldObject.type == newObject.type &&
          oldObject.size == newObject.size)] = newObject;
    });
    widget.returnValue(selectedObjects);
  }
}
