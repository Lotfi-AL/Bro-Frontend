import 'package:bro/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bro/views/course/alternative.dart' as alt;

class AlternativeContainer extends StatefulWidget {
  AlternativeContainer({
    Key key,
    this.course,
    this.alternatives,
    this.name,
    this.isAnswer,
    this.answerId,
    this.clarification,
  }) : super(key: key);
  final Course course;
  final List alternatives;
  final String name;
  final bool isAnswer;
  final int answerId;
  final String clarification;
  @override
  _AlternativeContainerState createState() => _AlternativeContainerState();
}

class _AlternativeContainerState extends State<AlternativeContainer> {
  bool clicked = false;
  List alts;
  String validation;

  @override
  Widget build(BuildContext context) {
    alts = widget.alternatives;

    return Column(children: [
      Expanded(
          child: Container(
        padding: EdgeInsets.all(0),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 2,
          /* physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
          //2 columns, unless there is only one item in list
          crossAxisCount: alts.length == 1 ? 1 : 2, */
          children: List.generate(alts.length, (index) {
            return /* Center(child: Text(widget.alternatives[index]['name']) */
                Container(
                    width:
                        (MediaQuery.of(context).size.width - 2 * (2 - 1)) / 2,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: alt.Alternative(
                            widget.course,
                            index,
                            alts[index]['name'],
                            alts[index]['correct'],
                            alts[index]['image'],
                            widget.isAnswer)));
          }),
        ),
      )),
    ]);
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: GridView.count(
//             crossAxisCount: 2,
//             childAspectRatio: 1,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             children: List.generate(list.length, (index) {
//               return Alter.Alternative(
//                   index, list[index]['name'], list[index]['correct'], null);
//             })));
//   }
// }
