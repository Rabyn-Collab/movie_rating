import 'package:eve_flutter/view/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../provider/search_movie_provider.dart';
import '../services/connectivity_check.dart';



class SearchPage extends StatelessWidget {
  final ConnectivityStatus connects;
  SearchPage(this.connects);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            child: Consumer(
                builder: (context, ref, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: TextFormField(
                          controller: searchController,
                          onFieldSubmitted: (val) {
                            if(val.isEmpty){
                              Get.defaultDialog(
                                  title: 'Required',
                                  content: Text('search text required'),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close')
                                    )
                                  ]
                              );
                            }else{
                              ref.read(searchMovie.notifier).getData(val);
                              searchController.clear();
                            }

                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              border: OutlineInputBorder(),
                              hintText: 'Search For Movies',
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.search_rounded)
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                          child:   TabBarWidget(connects, true, searchMovie, '3'),
                        )
                      )
                    ],
                  );
                }
            ),
          ),
        )
    );
  }
}
