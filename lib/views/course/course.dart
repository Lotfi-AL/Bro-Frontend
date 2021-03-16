import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'queries.dart';
import 'info_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'dart:developer';
import 'package:bro/blocs/course/course_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bro/views/course/alternative_container.dart';

class CourseView extends StatefulWidget {
  CourseView({Key key}) : super(key: key);

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  Course data;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CourseBloc>(context).add(CourseRequested(course_id: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseStates>(
      builder: (context, state) {
        //log(state.toString());
        if (state is Loading) {
          return Scaffold(
            appBar: AppBar(title: Text("Loading")),
            body: CircularProgressIndicator(),
          );
        }

        if (state is Failed) {
          return Scaffold(
            appBar: AppBar(title: Text("     ")),
            body: Center(child: Text("Det har skjedd en feil")),
          );
        }

        if (state is Course_Success) {
          data = state.course;
          log(data.toString());
          return Scaffold(
            appBar: AppBar(title: Text(data.title)),
            body: _course_view_builder(context, data),
          );
        }
        if (state is Switch_to_Quiz) {
          return Scaffold(
            appBar: AppBar(title: Text(data.title)),
            body: Center(child: AlternativeContainer()),
          );
        }
      },
    );
  }
}

Widget _course_view_builder(context, data) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      child: CardContainerView(
        list: data.slides,
      ));
}

class CardContainerView extends StatefulWidget {
  CardContainerView({
    Key key,
    this.list,
    this.res,
  }) : super(key: key);
  final List list;
  final QueryResult res;
  @override
  _CardContainerViewState createState() => _CardContainerViewState();
}

class _CardContainerViewState extends State<CardContainerView> {
  ScrollController _controller;
  double indx = 0;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

//ScrollController functions for swiping right and left
  void _moveRight() {
    _controller
        .animateTo(_controller.offset + context.size.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size.width;
            }));
  }

  void _moveLeft() {
    _controller
        .animateTo(_controller.offset - context.size.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size.width;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (context == null) {
      return Scaffold(body: Text('Context is null, yo'));
    }

    if (widget.list.isNotEmpty) {
      return Column(children: [
        FloatingActionButton(
          child: Text('test'),
          onPressed: () {
            BlocProvider.of<CourseBloc>(context).add(QuizSwitchRequested());
          },
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InfoCard(
                      title: widget.list[index]['title'],
                      description: widget.list[index]['description'],
                      image: widget.list[index]['image']);
                })),
        //Shows which page the user is on
        DotsIndicator(
            dotsCount: widget.list.length,
            position: indx.roundToDouble(),
            decorator: DotsDecorator(
                color: Colors.grey[350], activeColor: Colors.teal)),
        //Scroll buttons
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
              onTap: () => {_moveLeft()},
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.teal,
                        size: 72,
                      )))),
          GestureDetector(
              onTap: () => {_moveRight()},
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.teal,
                        size: 72,
                      )))),
        ])
      ]);
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }
}
