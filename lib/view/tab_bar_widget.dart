import 'package:cached_network_image/cached_network_image.dart';
import 'package:eve_flutter/services/connectivity_check.dart';
import 'package:eve_flutter/utils/toast_alert.dart';
import 'package:eve_flutter/view/detail_page.dart';
import 'package:eve_flutter/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../provider/search_movie_provider.dart';
import '../utils/star_calculator.dart';


class TabBarWidget extends StatelessWidget {
 
final ConnectivityStatus connects;
final bool isSearch;
final movieProvider;
final String pageKey;
TabBarWidget(this.connects, this.isSearch, this.movieProvider, this.pageKey);
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, ori) {
        return Container(
          child: Consumer(
              builder: (context, ref, child) {
                final movieData =isSearch ?ref.watch(searchMovie): ref.watch(movieProvider);
                if (movieData.isLoad) {
                  return Center(child:  CustomLoadingSpinKitRing());
                } else if (movieData.errMessage.isNotEmpty) {
                  if (movieData.errMessage == 'search not match') {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Try Using another keyword'),
                      ],
                    );
                  } else {
                    if (movieData.errMessage == 'No Internet.') {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(connects == ConnectivityStatus.OFF || connects == ConnectivityStatus.CHECK
                              ? 'No Internet'
                              : 'Internet available', style: TextStyle(
                              fontSize: 20,
                              color:  Colors
                                  .white),),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: () {
                            ref.read(movieProvider.notifier).getData();
                          }, child: Text('ReLoad'))
                        ],
                      );
                    } else {
                      return Center(
                          child: Text(movieData.errMessage));
                    }
                  }
                } else {
                  return NotificationListener(
                    onNotification: (onNotification) {
                      if (onNotification is ScrollEndNotification) {
                        final before = onNotification.metrics.extentBefore;
                        final max = onNotification.metrics.maxScrollExtent;
                        if (before == max) {
                          if (connects == ConnectivityStatus.ON) {
                            ref.read(movieProvider.notifier).loadMore();
                          }
                        }
                      }
                      return false;
                    },
                    child: GridView.builder(
                      key: PageStorageKey<String>(pageKey),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                            .onDrag,
                        itemCount: movieData.movies.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 6,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 15
                        ),
                        itemBuilder: (context, index) {
                          final movie = movieData.movies[index];
                          List<Widget> stars = StarCalculator.getStars(rating:movieData.movies[index].vote_average, starSize: 2.h);
                          return InkWell(
                            onTap: () {
                              if (connects == ConnectivityStatus.ON ) {
                                FocusScope.of(context).unfocus();
                                Get.to(() =>
                                    DetailPage(movieData.movies[index], connects),
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
                                            imageUrl: movieData.movies[index]
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
              }
          ),
        );
      }
    );
  }
}
