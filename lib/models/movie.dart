import 'package:eve_flutter/models/genres.dart';
import 'package:hive/hive.dart';
part 'movie.g.dart';



@HiveType(typeId: 0)
class Movie extends HiveObject{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String release_date;

  @HiveField(4)
  final double vote_average;

  @HiveField(5)
  final bool isFavorite;

  @HiveField(6)
  final String poster_path;

  @HiveField(7)
  final List<Genres> genres;


  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.release_date,
    required this.vote_average,
    required this.poster_path,
    required this.isFavorite,
    required this.genres
});


  factory Movie.fromJson(Map<String, dynamic> json){

    return Movie(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        overview: json['overview'] ?? '',
        release_date: json['release_date'] ?? '',
        vote_average:json['vote_average'] == null ? 0.0 :double.parse('${json['vote_average']}'),
      poster_path:json['poster_path'] == null ? '': 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${json['poster_path']}',
      isFavorite: false,
      genres: genresData.where((element) => (json['genre_ids'] as List).contains(element.id)).toList()
    );
  }


factory  Movie.empty(){
    return Movie(
        id: 0,
        title: 'no-data',
        overview:  '',
        release_date: '',
        vote_average: 0.0,
      poster_path: '',
        isFavorite: false,
      genres: []
    );
  }



}








