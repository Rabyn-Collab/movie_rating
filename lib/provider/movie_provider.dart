import 'package:dio/dio.dart';
import 'package:eve_flutter/api.dart';
import 'package:eve_flutter/models/movieState.dart';
import 'package:eve_flutter/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';


final popularMovie = StateNotifierProvider<PopularMovie, MovieState>((ref) => PopularMovie(MovieState.initState()));

class PopularMovie extends StateNotifier<MovieState>{
  PopularMovie(super.state){
    getData();
  }

  Future<void> getData() async{
    try{
        state = state.copyWith(isLoad: state.isLoadMore ? false:  true, apiPath:  Api.getPopularMovie);
        final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
        state = state.copyWith(
            isLoad: false,
            movies: [...state.movies, ...response],
            errMessage: ''
        );
    }catch(err){
      state = state.copyWith(
          errMessage: err as String,
          isLoad: false
      );
    }
  }

  void loadMore(){
    state = state.copyWith(
        page: state.page + 1,
        isLoadMore: true,
        searchText: state.searchText
    );
    getData();
  }

}



final topRated = StateNotifierProvider<TopRated, MovieState>((ref) => TopRated(MovieState.initState()));

class TopRated extends StateNotifier<MovieState>{
  TopRated(super.state){
    getData();
  }

  Future<void> getData() async{
    try{
      state = state.copyWith(isLoad: state.isLoadMore ? false:  true, apiPath:  Api.getTopRatedMovie);
      final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
      state = state.copyWith(
          isLoad: false,
          movies: [...state.movies, ...response],
          errMessage: ''
      );
    }catch(err){
      state = state.copyWith(
          errMessage: err as String,
          isLoad: false
      );
    }
  }

  void loadMore(){
    state = state.copyWith(
        page: state.page + 1,
        isLoadMore: true,
        searchText: state.searchText
    );
    getData();
  }

}




final upcoming = StateNotifierProvider<UpComing, MovieState>((ref) => UpComing(MovieState.initState()));

class UpComing extends StateNotifier<MovieState>{
  UpComing(super.state){
    getData();
  }

  Future<void> getData() async{
    try{
      state = state.copyWith(isLoad: state.isLoadMore ? false:  true, apiPath:  Api.getUpComingMovie);
      final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
      state = state.copyWith(
          isLoad: false,
          movies: [...state.movies, ...response],
          errMessage: ''
      );
    }catch(err){
      state = state.copyWith(
          errMessage: err as String,
          isLoad: false
      );
    }
  }

  void loadMore(){
    state = state.copyWith(
        page: state.page + 1,
        isLoadMore: true,
        searchText: state.searchText
    );
    getData();
  }

}







final movieByGenre = FutureProvider.family((ref, int id) => MoviePro(MovieState.initState()).getGenreMovie(id));

class MoviePro extends StateNotifier<MovieState>{
  MoviePro(super.state);

  Future<List<Movie>> getGenreMovie(int id) async{
    try{
        state = state.copyWith(isLoad: state.isLoadMore ? false: true);
        final response = await MovieService.movieByGenre(apiPath: Api.getGenreMovie, page: 1, id: id);
        return response;
    }catch(err){
      throw err;
    }
  }




}





