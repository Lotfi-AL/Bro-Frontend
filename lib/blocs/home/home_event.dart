import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent();

  @override
  List get props => [];
}

class HomeRequested extends HomeEvent {
<<<<<<< HEAD
  final String preferredLanguageSlug;

  // Sets "NO" to default if no preferredLanguageSlug is defined
  HomeRequested({preferredLanguageSlug})
      : preferredLanguageSlug = preferredLanguageSlug ?? 'NO';

  @override

  // This defines the props you need to check to determine if the state has changed.
  List get props => [preferredLanguageSlug];
=======
  // final Home home;
  // final List<Course> recommendedCourses;
  // HomeRequested({this.home,this.recommendedCourses});
  // @override
  // // This defines the props you need to check to determine if the state has changed.
  // List get props => [home, recommendedCourses];
>>>>>>> dev
}
