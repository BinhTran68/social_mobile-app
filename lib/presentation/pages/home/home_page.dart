import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/pages/home/widget/igtv._button_icon.dart';
import 'package:instagram_app/presentation/pages/home/widget/message_fly_icon_button.dart';
import 'package:instagram_app/presentation/widgets/app_icon_widget.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/circular_image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.indicatorColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset("assets/images/camera_icon.png"),
          onPressed: () {},
        ),
        title: appIconWidget(theme: theme),
        actions: [
          iGTVButton(onPressed: () {}),
          messageFlyIconButton(onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 9),
              child: circularImageWidget(
                  url:
                      "https://didongviet.vn/dchannel/wp-content/uploads/2022/01/cute-didongviet.jpg",
                  name: "Your story"),
            ),
            Divider(
              height: 0.1,
              color: secondaryColor.withAlpha(60),
            ),
            // Post
            SizedBox(
              width: double.infinity,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      sizeHor(10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appTextWidget(text: "name"),
                          appTextWidget(text: "address"),
                        ],
                      ),
                      Spacer(),
                      Image.asset("assets/images/More_Icon.png")
                    ],
                  )),
            ),
            Container(
              color: Colors.amber,
              child: Builder(builder: (context) {
                return CarouselSlider(
                    items: imgList
                        .map((item) => Center(
                                child: Image.network(
                              item,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      animateToClosest: true,
                      enlargeCenterPage: false,
                      // autoPlay: false,
                    ));
              }),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 14.w, right: 14.w, top: 13.5.h, bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              parentIcon(
                                  icon: SvgPicture.asset(
                                      "assets/svgs/heart-svgrepo-com.svg",
                                      color: Colors.white)),
                              sizeHor(18.w),
                              parentIcon(icon:  Image.asset("assets/images/Comment.png")),
                              sizeHor(18.w),
                              parentIcon(icon:   Image.asset("assets/images/message_fly_icon.png"),)
                            ],
                          ),
                        ),
                        const Expanded(child: Text(". . .")),
                        parentIcon(icon: Image.asset("assets/images/Save.png"))
                      ],
                    ),
                  ),
                  appTextWidget(text: "Liked by "),
                  sizeVer(6.h),
                  appTextWidget(text: "Content "),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget parentIcon({required Widget icon}) {
  return SizedBox(
    width: 22.w,
    height: 22.h,
    child: icon,
  );
}
