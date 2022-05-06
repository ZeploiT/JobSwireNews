import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ArticlePage extends StatelessWidget {
  final String imageUrl, title, source, description, url;
  const ArticlePage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.description,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          maxLines: 3,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    colorBlendMode: BlendMode.darken,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: ClipOval(
                      child: Material(
                        color: Colors.orange[700],
                        child: InkWell(
                          splashColor: Colors.orange[900],
                          onTap: () {
                            Share.share(url);
                          },
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Container(
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
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
