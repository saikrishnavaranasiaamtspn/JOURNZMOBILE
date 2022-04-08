import 'package:flutter/material.dart';

import 'package:journz_web/NewHomePage/Components/home_body_center_pane_article_section.dart';
import 'package:journz_web/NewHomePage/Components/home_page_body_center_pane_subtype_header.dart';
import 'package:journz_web/NewHomePage/Components/left_pane_profile.dart';
import 'package:journz_web/Tab/tab_home_body_center_pane_article_section.dart';
import 'package:journz_web/Tab/tab_home_page_body_center_pane_article_subtype_header.dart';

import 'package:velocity_x/velocity_x.dart';

import '../MiniDesktop/mini_desktop_home_body_center_pane_article_section.dart';
import '../MiniDesktop/mini_desktop_home_page_body_center_pane_subtype_header.dart';
import 'mobile_home_body_center_pane_article_section.dart';
import 'mobile_home_page_body_center_pane_article_subtype_header.dart';



class MobileBodyCenterPane extends StatefulWidget {
  /* final ShowCurrentlySelectedSubtypeCubit showCurrentSubtypeNameCubit; */
  const MobileBodyCenterPane({
    Key? key,
    /* required this.showCurrentSubtypeNameCubit */
  }) : super(key: key);

  @override
  _BodyCenterPaneState createState() => _BodyCenterPaneState();
}

class _BodyCenterPaneState extends State<MobileBodyCenterPane> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      /*  padding: EdgeInsets.only(
        top: context.screenHeight * 0.0075,
        left: context.screenWidth * 0.005,
        right: context.screenWidth * 0.005,
      ), */
      duration: Duration(milliseconds: 300),
      // width: context.screenWidth * 0.55,
      //height: context.screenHeight * 0.865,
      //color: Colors.grey.shade50,
      child: SingleChildScrollView(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [




            Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MobileBodyCenterPaneSubtypeHeader(
                    /*  showCurrentSubtypeNameCubit:
                          widget.showCurrentSubtypeNameCubit */
                  ),
                  SizedBox(height: context.screenHeight * 0.005),
                  MobileBodyCenterPaneArticleSection()
                ],
              ),
            )




          ],
        ),
      ),
    );
  }
}