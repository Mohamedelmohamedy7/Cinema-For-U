import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/models/PopularResponse/PopularSuccessResponse.dart';
import 'package:movie_app/providers/Movies_Provider.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomePage.dart';
import 'package:movie_app/widgets/custem_Text.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  var list;
  Details(this.list);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details".tr,style: TextStyle(
            color: accentColor
          ),),
          backgroundColor: primaryColor,
          leading: Align(
            child: IconButton(
              icon:const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: accentColor,
              ),
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage())),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFF181818),
                  const Color(0xFFC69634),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.45, 0.8],
                tileMode: TileMode.clamp),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 450,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "$BaseImage_Url${widget.list.backdrop_path}",
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 220.0),
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: primaryColor),
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 80,
                              color: greyColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                      child: Text("${widget.list.title}",
                          style: TextStyle(
                            fontSize: 23,
                          )),
                    ),
                  ),
                  const   SizedBox(height: 15,),

                        CustemText(
                          text: "🌟 ${widget.list.vote_average}",
                          fontSize: 25,
                          color: Colors.white,
                        ),
                  SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Adult : false",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        Text("${widget.list.release_date}",
                            style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        Text("Language :${widget.list.original_language}".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 15,right: 10),
                          child:
                          Text(
                            "Description".tr,
                            style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Align(
                       alignment: Alignment.topLeft,
                       child: Directionality(
                         textDirection: TextDirection.ltr,
                         child: Text("${widget.list.overview}",
                                  style: TextStyle(
                                    color: Colors.white,
                                     fontSize: 15,
                                  ),maxLines: 5,
                              ),
                       ),
                     ),
                   ],
                 ),
               ),

                  Builder(builder: (ctx) {
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          right: 30,
                        ),
                        child: Container(
                          width: 80,
                          height: 80,
                          child: IconButton(
                            icon: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accentColor,
                              ),
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Results movie = Results(
                                title: widget.list.title,
                                id: widget.list.id,
                                 backdrop_path: widget.list.backdrop_path,
                                original_language: widget.list.original_language,
                                overview: widget.list.overview,
                                popularity: widget.list.popularity,
                                poster_path: widget.list.poster_path,
                                release_date: widget.list.release_date,
                                vote_count: widget.list.vote_count,
                                original_title: widget.list.original_title,
                                vote_average: widget.list.vote_average,
                              );
                              Provider.of<Movies_Providers>(context,
                                      listen: false)
                                  .insertFav(movie, ctx);
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
