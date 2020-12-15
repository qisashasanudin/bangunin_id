import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WeeklyProgress extends StatefulWidget {
  const WeeklyProgress({
    Key key,
    @required this.target,
  }) : super(key: key);

  final List<MaterialModel> target;

  @override
  _WeeklyProgressState createState() => _WeeklyProgressState();
}

class _WeeklyProgressState extends State<WeeklyProgress> {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/UI/character.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              myArticles("assets/img/UI/home_bg_default4.jpg",
                  "Perbaikan Atap Rumah", "perbaikan atap rumah"),
              myArticles("assets/img/UI/home_bg_default1.jpg",
                  "Perbaikan depan rumah", "perbaikan depan rumah"),
              myArticles("assets/img/UI/home_bg_default2.jpg",
                  "Perbaikan depan rumah", "perbaikan depan rumah"),
              myArticles("assets/img/UI/home_bg_default4.jpg",
                  "Perbaikan depan rumah", "perbaikan depan rumah"),
              myArticles("assets/img/UI/home_bg_default4.jpg",
                  "Perbaikan depan rumah", "perbaikan depan rumah"),
            ],
          ),
        ),
        separatorLine(),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.target.length,
          itemBuilder: (_, index) {
            return itemProgress(context, index, widget.target[index], 0.50);
          },
        ),
      ],
    );
  }
}
//========================= main function =========================

Container myArticles(String imageVal, String heading, String subHeading) {
  return Container(
    width: 250.0,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shadowColor: Color(0x802196F3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Image.asset(imageVal),
            ListTile(
              title: Text(heading),
              subtitle: Text(subHeading),
            )
          ],
        ),
      ),
    ),
  );
}

Padding separatorLine() {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Divider(color: Colors.black));
}

SizedBox itemProgress(
    BuildContext context, int index, MaterialModel item, double percentage) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '${index + 1}. ${item.name} ${item.size} ${item.type} (${item.amount} ${item.unit})',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            progressColor: Theme.of(context).primaryColor,
            animation: true,
            lineHeight: 30,
            percent: percentage,
            center: Text('${percentage * 100}%',
                style: TextStyle(color: AppColors().accent1)),
          ),
        ],
      ),
    ),
  );
}
