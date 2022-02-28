import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_integration/Model/newsInfo.dart';
import 'package:rest_api_integration/Services/api_manages.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> _newsModel;

  @override
  void initState() {
  _newsModel  =  Api_Manager().getNews();
    print("-----------------------------------------------");
    print(_newsModel);
    print("-----------------------------------------------");
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App",),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return  ListView.builder(
                itemCount: snapshot.data.articles.length,
                itemBuilder: (context,index){
                   var articles = snapshot.data.articles[index];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 100,
                      //width: 100,
                      //color: Colors.red,
                      child: Row(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                              child: Image.network(
                                articles.urlToImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(articles.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,

                                ),
                                ),
                                Text(articles.description,
                                overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else {
              return Center(
                  child: CircularProgressIndicator(),

              );
            }
          },
        ),
      ),
    );
  }
}
