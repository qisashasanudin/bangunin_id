import 'package:bangunin_id/screens/mainmenu/home/projects/project_materials/dynamic_widget.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

class ProjectMaterialsList extends StatefulWidget {
  @override
  _ProjectMaterialsListState createState() => _ProjectMaterialsListState();
}

class _ProjectMaterialsListState extends State<ProjectMaterialsList> {
  List<DynamicWidget> _dynamicList = [DynamicWidget()];

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
            itemCount: _dynamicList.length,
            itemBuilder: (context, index) {
              return _dynamicList[index];
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _editMaterialListButton(
                  Text(
                    '+',
                    style: TextStyle(fontSize: 25, color: AppColors().accent1),
                  ),
                  _addList),
              _editMaterialListButton(
                  Text(
                    '-',
                    style: TextStyle(fontSize: 25, color: AppColors().accent1),
                  ),
                  _removeList),
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
        color: Theme.of(context).primaryColor,
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
    if (_dynamicList.length < 2) {
      return;
    }
    _dynamicList.removeLast();
    setState(() {});
  }
}
