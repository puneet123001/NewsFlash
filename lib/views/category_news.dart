import 'package:flutter/material.dart';
import 'package:newsflash/helper/news.dart';
import 'package:newsflash/models/article_model.dart';
import 'package:newsflash/views/home.dart';
class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({required this.category,super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles=[];
  bool _loading =true;

  @override
  void initState(){
    super.initState();

   getCategoryNews();
  }
  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "News",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "flash",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.share,))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:_loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
            child: Container(
        child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height ,
                padding: const EdgeInsets.all( 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,);
                    }),
              )
            ],
        ),
      ),
          ),
    );
  }
}
