import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/models/home.dart';
import 'package:bro/models/courses.dart';
import 'package:bro/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data/Non_Lang_courses_list_mock.dart';

class MockHomeView extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<HomeState>(Failed());
    registerFallbackValue<HomeEvent>(HomeRequested());
  });

  mainTest();
}

void mainTest() {
  group('HomeView', () {
    late HomeBloc homeViewBloc;

    setUp(() {
      homeViewBloc = MockHomeView();
    });

    tearDown(() {
      homeViewBloc.close();
    });

    testWidgets('renders properly without courses and home',
        (WidgetTester tester) async {
      when(() => homeViewBloc.state).thenReturn(Success(
          courses: [],
          hasReachedMax: true,
          home: Home(header: '', introduction: '')));
      await tester.pumpWidget(
        BlocProvider.value(
          value: homeViewBloc,
          child: MaterialApp(
            home: Scaffold(
              body: HomeView(),
            ),
          ),
        ),
      );
    });
    testWidgets('renders properly with courses and Home',
        (WidgetTester tester) async {
      var successlist =
          LangCourse.fromJson(non_lang_courses_mock['data']!['LangCourse']![0]);
      when(() => homeViewBloc.state).thenReturn(
        Success(
            courses: [successlist],
            hasReachedMax: true,
            home: Home(
                header: 'Velkommen til Bro',
                introduction:
                    'Dette er en introduksjons tekst som skal være passe lang.')),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: homeViewBloc,
          child: MaterialApp(
            home: Scaffold(
              body: HomeView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Velkommen til Bro'), findsOneWidget);
      await tester.tap(find.text('Anbefalte Kurs'));
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Desc'), findsOneWidget);
      await tester.tap(find.text('Hva er Bro?'));
      expect(
          find.text(
              'Dette er en introduksjons tekst som skal være passe lang.'),
          findsOneWidget);
    });
  });
}
