import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/course.dart';
import 'package:bro/views/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../mock_data/course_detail_mock.dart';

class MockCourseDetailBloc
    extends MockBloc<CourseDetailEvent, CourseDetailState>
    implements CourseDetailBloc {}

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(Failed(err: 'Failed'));
    registerFallbackValue<CourseDetailEvent>(
        CourseDetailRequested(courseId: 1, isAnswer: false, isQuiz: false));
  });

  mainTest();
}

void mainTest() {
  group('CourseDetailView', () {
    CourseRepository courseRepository;
    late CourseDetailBloc courseDetailBloc;
    late Course refCourse;

    setUp(() {
      courseRepository = MockCourseRepository();
      when(() => courseRepository.getCourse(any())).thenAnswer((_) =>
          Future.value(QueryResult(source: null, data: course_detail_mock)));
      courseDetailBloc = MockCourseDetailBloc();
      refCourse = referenceCourse;
    });

    tearDown(() {
      courseDetailBloc.close();
    });

    testWidgets('renders properly with inserted data',
        (WidgetTester tester) async {
      when(() => courseDetailBloc.state).thenAnswer((_) =>
          CourseState(course: refCourse, isQuiz: false, isAnswer: false));

      tester.binding.window.physicalSizeTestValue = Size(600, 1920);
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseDetailBloc,
          child: MaterialApp(
            home: Scaffold(
                body: CourseDetailView(
              courseId: 1,
            )),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.text('En meget fin testcourse'), findsOneWidget);
      expect(find.text('Testslide'), findsOneWidget);
    });
    testWidgets('navigation arrows and start quiz appears on last slide',
        (WidgetTester tester) async {
      when(() => courseDetailBloc.state).thenAnswer((_) =>
          CourseState(course: refCourse, isQuiz: false, isAnswer: false));
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseDetailBloc,
          child: MaterialApp(
            home: Scaffold(
                body: CourseDetailView(
              courseId: 1,
            )),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('DEN ANDRE MEGET FINE TESTSLIDEN'), findsNothing);
      expect(find.text('Testslide'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_circle_down).last);
      await tester.pumpAndSettle();
      expect(find.text('DEN ANDRE MEGET FINE TESTSLIDEN'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
