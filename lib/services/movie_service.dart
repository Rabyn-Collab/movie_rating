import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eve_flutter/api.dart';
import 'package:eve_flutter/models/movie.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../exceptions/api_exception.dart';





class  MovieService {

  static Future<List<Movie>>  getMovieByCategory({required apiPath, required int page}) async{

    final dio = Dio();
    try{

      if(apiPath == Api.getPopularMovie){
        final response = await dio.get(apiPath,
            queryParameters: {
              'api_key': '2a0f926961d00c667e191a21c14461f8',
              'page': 1
            }
        );

        final box = Hive.box<String>('data');
        box.put('movie', jsonEncode(response.data['results']));
      }
        final response = await dio.get(apiPath,
            queryParameters: {
              'api_key': '2a0f926961d00c667e191a21c14461f8',
              'page': page
            }
        );
        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return data;

    }on DioError catch(err){
          if(apiPath == Api.getPopularMovie){
            final box = Hive.box<String>('data');
            final data = box.get('movie');
            if(box.isNotEmpty) {
              final dat = ( jsonDecode(data!) as List).map((e) => Movie.fromJson(e)).toList();
              return dat;
            }else {
              throw DioException.fromDioError(err).errorMessage;
            }

          }else{
            throw DioException.fromDioError(err).errorMessage;
          }


    }
  }



  static Future<List<Movie>>  searchMovieBy({required apiPath, required int page, required String searchText}) async{

    final dio = Dio();

    try{
      final response = await dio.get(apiPath,
          queryParameters: {
            'api_key': '2a0f926961d00c667e191a21c14461f8',
            'page': page,
            'query': searchText
          }
      );
      if((response.data['results'] as List).isEmpty){
        throw  'search not match';
      }else{
        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return data;
      }
    }on DioError catch(err){
      throw DioException.fromDioError(err).errorMessage;

    }
  }


  static Future<List<Movie>>  movieByGenre({required apiPath, required int page, required int id}) async{

    final dio = Dio();

    try{
      final response = await dio.get(apiPath,
          queryParameters: {
            'api_key': '2a0f926961d00c667e191a21c14461f8',
            'page': page,
            'with_genres': id
          }
      );
        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return data;
    }on DioError catch(err){
      throw DioException.fromDioError(err).errorMessage;

    }
  }




}

