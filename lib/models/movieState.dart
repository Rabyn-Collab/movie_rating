import 'package:eve_flutter/api.dart';

import 'movie.dart';



class MovieState{

  final String apiPath;
  final bool isLoad;
  final String errMessage;
  final String searchText;
  final List<Movie> movies;
  final int page;
  final bool isLoadMore;



  MovieState({
    required this.errMessage,
    required this.isLoad,
    required this.movies,
    required this.apiPath,
    required this.page,
    required this.searchText,
    required this.isLoadMore
});

MovieState.initState(): searchText='', page=1, apiPath=Api.getPopularMovie, movies=[], isLoad=false, errMessage='',
      isLoadMore= false
  ;

MovieState copyWith({
  String? apiPath,
  bool? isLoad,
  String? errMessage,
  String? searchText,
  List<Movie>? movies,
  int? page,
  bool?  isLoadMore
}){
  return MovieState(
      errMessage: errMessage ?? this.errMessage,
      isLoad: isLoad ?? this.isLoad,
      movies: movies ?? this.movies,
      apiPath: apiPath ?? this.apiPath,
      page: page ?? this.page,
      searchText: searchText ?? this.searchText,
    isLoadMore:  isLoadMore ?? this.isLoadMore
  );
}


}