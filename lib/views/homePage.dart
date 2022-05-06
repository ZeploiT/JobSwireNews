import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobswire_case_project/Views/articlePage.dart';
import 'package:jobswire_case_project/models/articleModels.dart';

import '../Service/apiService.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  List<ArticleModel> newsList = [];

// function that get news from api
  void getNews() {
    ApiService.getNews().then((data) {
      Map resultBody = json.decode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          Iterable result = resultBody['result'];
          newsList = result.map((newsList) => ArticleModel(newsList)).toList();
        });
      } else {
        SnackBar(content: Text("Something's went wrong!"));
      }
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (newsList.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getNews();
            });
            return await Future.delayed(Duration(seconds: 1));
          },
          edgeOffset: 100,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 50.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'JobSwire',
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 117, 108)),
                      ),
                      Text(
                        'News',
                        style: TextStyle(
                            color: Color.fromARGB(254, 185, 235, 204)),
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return GestureDetector(
                      //tile ontap
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticlePage(
                                    imageUrl: newsList[index].image,
                                    title: newsList[index].name,
                                    source: newsList[index].source,
                                    description: newsList[index].description,
                                    url: newsList[index].url,
                                  )),
                        );
                      },
                      child: NewsTileStyle(
                          imageUrl: newsList[index].image,
                          title: newsList[index].name,
                          source: newsList[index].source),
                    );
                  },
                  childCount: newsList.length,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

//tile styles
class NewsTileStyle extends StatelessWidget {
  final String imageUrl, title, source;
  const NewsTileStyle(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.source})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 3, right: 3),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200.0,
            width: double.infinity,
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 244, 117, 108),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              source,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }
}
