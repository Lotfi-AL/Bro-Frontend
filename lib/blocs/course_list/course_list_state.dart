import 'package:bro/models/courses.dart';
import 'package:equatable/equatable.dart';

abstract class CourseListState extends Equatable {
  CourseListState();

  @override
  List<Object> get props => [];
}

class Initial extends CourseListState {}

class Loading extends CourseListState {}

class Success extends CourseListState {
  final List<LangCourse> courses;
  final bool hasReachedMax;

  Success({required this.courses, required this.hasReachedMax});

  Success copyWith({
    required List<LangCourse> courses,
    bool? hasReachedMax,
  }) {
    return Success(courses: courses, hasReachedMax: hasReachedMax ?? false);
  }

  @override
  List<Object> get props => [courses, hasReachedMax];

  @override
  String toString() =>
      'Success { courses: $courses, hasReachedMax: $hasReachedMax }';
}

class Failed extends CourseListState {}
