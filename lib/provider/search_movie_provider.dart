import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api.dart';
import '../models/movieState.dart';
import '../services/movie_service.dart';


final searchMovie = StateNotifierProvider.autoDispose<SearchMovie, MovieState>((ref) => SearchMovie(MovieState.initState()));

class SearchMovie extends StateNotifier<MovieState>{
  SearchMovie(super.state);

  Future<void> getData(String searchText) async{
    try{
      state = state.copyWith(isLoad:   true, apiPath:  Api.getSearchMovie);
      final response = await MovieService.searchMovieBy(apiPath: state.apiPath, page: 1, searchText: searchText);
      state = state.copyWith(
          isLoad: false,
          movies: response,
          errMessage: ''
      );
    }catch(err){
      state = state.copyWith(
          errMessage: err as String,
          isLoad: false
      );
    }
  }



}









