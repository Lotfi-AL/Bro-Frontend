import 'package:bro/views/flutter-demo/demoscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bro/views/main.dart';
import 'package:bro/models/course.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'extract_route_args.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List <GlobalKey<NavigatorState>> _NavKeys = [
    _homeNavKey,
    _articleNavKey,
    _courseNavKey,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          HomeTab(),
          ArticleTab(),
          CourseTab(),

        ],
      /*Navigator(
        key: widget.navKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => Home();
              break;
            case ExtractCourseDetailScreen.routeName:
              builder =
                  (context) => ExtractCourseDetailScreen(client: _client());
              break;
            case ExtractCourseListScreen.routeName:
              builder = (context) => ExtractCourseListScreen(client: _client());
              break;
            case ExtractCategoryListScreen.routeName:
              builder =
                  (context) => ExtractCategoryListScreen(client: _client());
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },*/
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Hjem',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: 'Artikler',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCheckSquare),
            label: 'Kurs',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cog),
            label: 'Instillinger',
            backgroundColor: Colors.teal,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.tealAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
}
GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();
class _HomeTabState extends State<HomeTab> {
  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL']! + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: _homeNavKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case '/':
                    return ExtractRecommendedScreen(client: _client());
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                };
              });
        });
  }
}
class CourseTab extends StatefulWidget {

  @override
  _CourseTabState createState() => _CourseTabState();
}
GlobalKey<NavigatorState> _courseNavKey = GlobalKey<NavigatorState>();

class _CourseTabState extends State<CourseTab> {
  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL']! + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _courseNavKey,
      initialRoute: '/courseList',
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context){
              switch (settings.name){
                case ExtractCourseListScreen.routeName:
                  return ExtractCourseListScreen(client: _client());
                case ExtractCourseDetailScreen.routeName:
                  return ExtractCourseDetailScreen(client: _client());
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
            });
      });
  }
}

class ArticleTab extends StatefulWidget {
  @override
  _ArticleTabState createState() => _ArticleTabState();
}
GlobalKey<NavigatorState> _articleNavKey = GlobalKey<NavigatorState>();

class _ArticleTabState extends State<ArticleTab> {
  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL']! + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _articleNavKey,
      initialRoute: '/categoryList',
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          settings: settings,
          builder:(BuildContext context){
            switch(settings.name){
              case ExtractCategoryListScreen.routeName:
                return ExtractCategoryListScreen(client: _client());
              default:
                throw Exception('Invalid route: ${ExtractCategoryListScreen.routeName}');
            }
          });
      });
  }
}

