import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final keyProvider = FutureProvider.family((ref, int id) => MovieKeyProvider().getMovieKey(id));

class MovieKeyProvider {

  Future<String> getMovieKey(int id) async{
    final dio = Dio();
    try{
      final response = await dio.get('https://api.themoviedb.org/3/movie/$id/videos',
          queryParameters: {
            'api_key': '2a0f926961d00c667e191a21c14461f8',
          }
      );
      if((response.data['results'] as List).isEmpty){
        return '';
      }else{
        return  response.data['results'][0]['key'];
      }

    } on DioError catch(err){
      return '';
    }
  }

}