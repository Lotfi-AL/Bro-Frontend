import 'dart:async';

import 'package:bro/data/queries/course_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class HomeRepository {
  final GraphQLClient client;

  HomeRepository({required this.client}) : assert(client != null);

  // Course type should be made in a models/ directory
  Future<QueryResult> getRecommendedCourses(int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(getRecommendedCoursesQuery),
      fetchResults: true,
      variables: <String, dynamic>{'start': start, 'limit': limit},
    );

    return await client.query(_options);
  }

  Future<QueryResult> getHome() async {
    final _options = WatchQueryOptions(
      document: parseString(getHomeQuery),
      fetchResults: true,
    );

    return await client.query(_options);
  }
}