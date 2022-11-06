import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eve_flutter/api.dart';
import 'package:eve_flutter/provider/movie_provider.dart';
import 'package:eve_flutter/services/connectivity_check.dart';
import 'package:eve_flutter/view/search_page.dart';
import 'package:eve_flutter/view/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class HomePage extends StatelessWidget {






  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final connects = ref.watch(connectionProvider);
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 120,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Watch Now',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight
                              .bold),),
                        IconButton(
                            onPressed: () {
                          Get.to(() => SearchPage(connects),
                              transition: Transition.leftToRight);
                        }, icon: Icon(Icons.search, size: 30,))
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(double.infinity, 52),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10),
                      child: Consumer(
                          builder: (context, ref, child) {
                            return TabBar(
                                indicator: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                tabs: [
                                  Tab(
                                      text: 'Popular',
                                  ),
                                  Tab(
                                      text: 'Top_rated'
                                  ),
                                  Tab(
                                    text: 'UpComing',
                                  ),
                                ]

                            );
                          }
                      ),
                    ),
                  ),
                ),
                body:  Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    TabBarWidget(connects, false, popularMovie, '1'),
                                    TabBarWidget(connects, false, topRated, '2'),
                                    TabBarWidget(connects, false, upcoming, '3'),

                                  ]),
                            ),
                          )
                        ],
                      )

              );
            }
          )

        )

    );
  }
}
