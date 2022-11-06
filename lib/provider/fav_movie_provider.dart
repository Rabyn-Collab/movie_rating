import 'package:eve_flutter/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/movie.dart';



final favMovieProvider = StateNotifierProvider<FavMovie, List<Movie>>((ref) => FavMovie(ref.read(boxA)));


class FavMovie extends StateNotifier<List<Movie>>{
  FavMovie(super.state);



  void addMovie(Movie movie){
    Hive.box<Movie>('movies').add(movie);
    state = [...state, movie];
  }

  void removeMovie(Movie movie){
    movie.delete();
    state.remove(movie);
    state = [...state];
  }




}