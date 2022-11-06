import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eve_flutter/provider/fav_movie_provider.dart';
import 'package:eve_flutter/services/connectivity_check.dart';
import 'package:eve_flutter/utils/toast_alert.dart';
import 'package:eve_flutter/view/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../utils/star_calculator.dart';
import '../widgets/loading_widget.dart';



class FavPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final movieData = ref.watch(favMovieProvider);
              final connects = ref.watch(connectionProvider);
              return   Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                            .onDrag,
                        itemCount: movieData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 6,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 15
                        ),
                        itemBuilder: (context, index) {
                          final movie = movieData[index];
                          List<Widget> stars = StarCalculator.getStars(rating:movieData[index].vote_average, starSize: 2.h);
                          return InkWell(
                              onTap: () {
                                if (connects == ConnectivityStatus.ON) {
                                  Get.to(() =>
                                      DetailPage(movieData[index],connects),
                                      transition: Transition.leftToRight);
                                } else {
                                  ToastShow.toastAlert(message: 'please check your connection');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: GridTile(
                                    header: Container(
                                      height: 270,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                              errorWidget: (c, s, d) =>
                                                  Image.asset(
                                                      'assets/images/movie.png'),
                                              placeholder: (context, st) => Center(
                                                  child: CustomLoadingSpinKitRing()
                                              ),
                                              fit: BoxFit.fitHeight,
                                              imageUrl: movieData[index]
                                                  .poster_path)
                                      ),
                                    ),
                                    child: Container(),
                                    footer: Container(
                                      color: Colors.black,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (stars.length != 0) Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Row(children: stars),
                                          ),
                                          Text(movie.title, style: TextStyle(fontSize: 20),),
                                          SizedBox(height: 10,),
                                          Text('${movie.overview}...', maxLines: 3, overflow: TextOverflow.ellipsis,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )

                          );
                        }
                    ),
              );

            }
    )
    );
  }
}
