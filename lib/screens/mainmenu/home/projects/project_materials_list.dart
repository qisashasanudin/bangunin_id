import 'package:flutter/material.dart';

class ProjectMaterialsList extends StatefulWidget {
  @override
  _ProjectMaterialsListState createState() => _ProjectMaterialsListState();
}

class _ProjectMaterialsListState extends State<ProjectMaterialsList> {
  List<DynamicWidget> _dynamicList = [];

  _addList() {
    _dynamicList.add(DynamicWidget());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _dynamicList.length,
            itemBuilder: (_, index) => _dynamicList[index],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: RaisedButton(
              child: Icon(Icons.add),
              onPressed: _addList,
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(hintText: 'Masukkan data'),
      ),
    );
  }
}
