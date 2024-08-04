import 'package:book_heaven/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:book_heaven/utility/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var user = context.userProvider.user;
    // print(user);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 1,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   key: Key('clearButton'),
                  //   icon: const Icon(Icons.clear),
                  //   onPressed: () {
                  //     searchController.clear();
                  //   },
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Book_Genres.length,
                    itemBuilder: (context, index) {
                      var genre = Book_Genres[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1)
                            .copyWith(right: 10),
                        child: ActionChip(
                            label: Text(genre),
                            onPressed: () {
                              setState(() {
                                searchController.text = genre;
                              });
                            }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
