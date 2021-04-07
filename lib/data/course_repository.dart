import 'dart:async';
import 'package:bro/data/queries/course_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CourseRepository {
  final GraphQLClient client;

  CourseRepository({required this.client});

  // Course type should be made in a models/ directory
  Future<QueryResult> getCourses(int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(getCoursesQuery),
      fetchResults: true,
      variables: <String, dynamic>{'start': start, 'limit': limit},
    );
    return await client.query(_options);
  }

  Future<QueryResult> getCourse(int i) async {
    final _options = WatchQueryOptions(
      document: parseString(getCourseQuery),
      variables: {'course_id': i},
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
