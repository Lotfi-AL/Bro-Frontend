import 'package:bro/blocs/course/course_bucket.dart';
import 'package:bro/blocs/simple_bloc_observer.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/views/course/course.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:bro/views/course/alternative_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(App());
}

// This widget is the root of your application.
class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQl Article',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(elevation: 5.0),
        iconTheme: IconThemeData(size: 18.0, color: Colors.white),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
          headline6: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.teal,
          ),
          subtitle1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.15,
            color: Colors.black,
          ),
          subtitle2: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.10,
            color: Colors.black,
          ),
          caption: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.40,
          ),
        ),
      ),
      routes: {
        'course-view': (_) => BlocProvider(
              create: (context) => CourseBloc(
                repository: CourseRepository(
                  client: _client(),
                ),
              ),
              child: CourseListView(),
            ),
        'test': (_) => BlocProvider(
              create: (context) => CourseBloc(
                repository: CourseRepository(
                  client: _client(),
                ),
              ),
              child: CourseView(),
            ),
      },
      home: Home(),
    );
  }

  GraphQLClient _client() {
    final HttpLink _link = HttpLink('https://bro-strapi.herokuapp.com/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Velkommen til Bro!"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("CourseListView"),
            onTap: () => Navigator.of(context).pushNamed('test'),
          ),
        ],
      ),
    );
  }
}