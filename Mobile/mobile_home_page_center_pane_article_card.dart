import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:journz_web/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileHomePageCenterPaneArticleCard extends StatefulWidget {
  final List<HiveArticleData> listOfArticles;
  final int index;

  const MobileHomePageCenterPaneArticleCard(
      {Key? key, required this.index, required this.listOfArticles})
      : super(key: key);

  @override
  _HomePageCenterPaneArticleCardState createState() =>
      _HomePageCenterPaneArticleCardState();
}

class _HomePageCenterPaneArticleCardState extends State<MobileHomePageCenterPaneArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 4),
              blurRadius: 4)
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(243, 243, 243, 1.0),
              Color.fromRGBO(255, 255, 255, 1)
            ]),
      ),
      height: context.screenHeight * 0.19,
      //width: context.screenWidth,
      child: Container(
        child: postcontent(widget.listOfArticles, widget.index),
      ),
    );
  }
}



Widget postcontent(List<HiveArticleData> listOfArticles, int index) {
  return Builder(
    builder: (context) {
      return Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(listOfArticles[index].articleTitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: context.screenHeight * 0.024)),
          SizedBox(
            height: (context.screenHeight * 0.19) * 0.03,
          ),
          Text(
            listOfArticles[index]
                .articleDescription
                .split(RegExp("<(“[^”]*”|'[^’]*’|[^'”>])*>"))
                .join("")
                .substring(0, 250),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: context.screenHeight * 0.02),
            maxLines: 2,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialcontainers(BlocBuilder<CheckuserloginedCubit,
                        CheckuserloginedState>(
                      builder: (context, loginState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            loginState.isLoggined!
                                ? listOfArticles[index].articleLike.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Image.asset(
                                        'assets/images/Okay2.png',
                                      )
                                        .box
                                        .width(
                                            (context.screenWidth - 40) * 0.05)
                                        .make()
                                    : Image.asset(
                                        'assets/images/Okayoutline1.png',
                                      )
                                        .box
                                        .width(
                                            (context.screenWidth - 40) * 0.05)
                                        .make()
                                : Image.asset(
                                    'assets/images/Okayoutline1.png',
                                  )
                                    .box
                                    .width((context.screenWidth - 40) * 0.05)
                                    .make(),
                            Container(
                              width: ((context.screenWidth - 45) * 0.19) * 0.3,
                              child: Text(
                                listOfArticles[index].noOflikes.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: context.screenHeight * 0.02),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ).box.width((context.screenWidth - 45) * 0.19).make();
                      },
                    )),
                    socialcontainers(
                      icon('assets/images/Chat2.png',
                          listOfArticles[index].noOfComments.toString()),
                    ),
                    socialcontainers(
                      icon('assets/images/Diamondcare.png',
                          listOfArticles[index].noOfViews.toString()),
                    ),
                    socialcontainers(icon(
                        'assets/images/Sharefilled2.png', '000000000000000000'))
                  ],
                ),
              ),
            ),
          )
        ],
      )
          .box
          .width((context.screenWidth - 45))
          .padding(EdgeInsets.fromLTRB(5, 15, 10, 0))
          .make();
    },
  );
}

Widget socialcontainers(Widget a) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
          // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 2),
                  blurRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(243, 243, 243, 1.0),
                  Color.fromRGBO(255, 255, 255, 1)
                ]),
          ),
          height: (context.screenHeight * 0.19) * 0.25,
          width: (context.screenWidth - 45) * 0.19,
          child: a);
    },
  );
}

Widget icon(String a, String b) {
  return Builder(builder: (context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(a, color: Color.fromRGBO(75, 74, 74, 1.0))
            .box
            .width((context.screenWidth - 40) * 0.05)
            .make(),
        Container(
          width: ((context.screenWidth - 45) * 0.19) * 0.3,
          child: Text(
            b,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: context.screenHeight * 0.02),
          ),
        )
      ],
    );
  });
}
