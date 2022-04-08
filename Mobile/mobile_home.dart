import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journz_web/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';

import 'package:journz_web/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:journz_web/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import 'package:journz_web/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';
import 'package:journz_web/Tab/tab_home_page_body_center_pane.dart';
import 'package:journz_web/Tab/tab_home_page_header.dart';

import '../drawer.dart';
import '/NewHomePage/Components/home_page_footer.dart';
import '/NewHomePage/Components/home_page_header.dart';
import 'package:velocity_x/velocity_x.dart';

import '/NewHomePage/Components/home_page_body_center_pane.dart';
import 'mobile_home_page_body_center_pane.dart';
import 'mobile_home_page_header.dart';

class MobileHome extends StatefulWidget {
  final bool? wantSearchBar;
  const MobileHome({Key? key, this.wantSearchBar}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MobileHome> {
  //late ShowCurrentlySelectedSubtypeCubit showCurrentlySelectedSubtypeCubit;

  @override
  void didChangeDependencies() {
    //context.read<CheckuserloginedCubit>().checkLogin();
    checkConnection();
    /* showCurrentlySelectedSubtypeCubit =
        context.read<ShowCurrentlySelectedSubtypeCubit>(); */
    super.didChangeDependencies();
  }

  checkConnection() async {
    ConnectivityResult event = await Connectivity().checkConnectivity();
    if (event != ConnectivityResult.none) {
      getDataFromDB();
    }
  }

  getDataFromDB() {
    context.read<GetArticleSubtypeCubit>().addSubtypeToHiveDb();
    context.read<GetArticlesFromCloudCubit>().getArticlesfromCloud();
  }

  @override
  Widget build(BuildContext context) {
    // getDataFromDB();
    context.read<CheckuserloginedCubit>().checkLogin();
    return Scaffold(
      drawerEdgeDragWidth: 0,
      drawer:Drawe(),
      body: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
        builder: (context, userState) {
          print('Navi User State ${userState.isLoggined!}');
          return Container(
            height: context.screenHeight,
            width: context.screenWidth,
            child:
            Column(
              children: [
                //SaiHeader(),
               MobileHomePageHeader(wantSearchBar: true),
                SizedBox(height: context.screenHeight * 0.015),
                BlocProvider(
                  create: (context) => ShowCurrentlySelectedSubtypeCubit(
                      userState: userState.isLoggined!),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //HomePageHeader(wantSearchBar: widget.wantSearchBar),
                        Container(

                          width: context.screenWidth,
                          //height: context.screenHeight * 0.865,
                          //color: Colors.white,
                          child: MobileBodyCenterPane(
                            /* showCurrentSubtypeNameCubit: context
                                    .read<ShowCurrentlySelectedSubtypeCubit>(), */
                          ),
                        ),
                        SizedBox(height: context.screenHeight * 0.03),

                        HomePageFooter()
                      ],
                    ),
                  ),
                )
                    .box
                    .width(context.screenWidth)
                    .height(context.screenHeight * 0.9)
                    .make(),

              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    //  Hive.close();
    super.dispose();
  }
}
