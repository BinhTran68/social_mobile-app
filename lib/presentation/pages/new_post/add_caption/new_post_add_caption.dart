import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_app/presentation/pages/new_post/add_caption/widgets/new_post_action.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/form_container_widget.dart';
import 'package:instagram_app/presentation/widgets/new_post_app_bar.dart';

class NewPostAddCaption extends StatelessWidget {
  NewPostAddCaption({
    super.key,
    required this.selectedImages,
  });

  List<Map<String, dynamic>> selectedImages;

  List<Widget> addCaptionActions = [
    newPostAction(),
    newPostAction(),
    newPostAction(),
    newPostAction(),
    newPostAction(),
    newPostAction(),
    newPostAction(),
    newPostAction(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: newPostAppBar(context, handleOnNext: () {
            // Đầu tiên lưu hình ảnh lấy về images
            // Tạo ra đối tượng entity sau đó tạo ra các bài viết

          }),
          body: Column(
            children: [
              Expanded(
                child: CarouselSlider(
                    items: selectedImages
                        .map((item) =>
                        Center(
                            child: Image.memory(
                              item['bytes'],
                              width: double.infinity,
                              fit: BoxFit.contain,
                            )))
                        .toList(),
                    options: CarouselOptions(
                        height: 290.h,
                        viewportFraction: 0.8,
                        animateToClosest: true,
                        enlargeCenterPage: false,
                        enableInfiniteScroll:
                        selectedImages.length > 1 ? true : false
                      // autoPlay: true,
                    )),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormContainerWidget(
                        height: 120.h,
                        hintText: "Write a caption or add poll",
                        inputColor: Colors.transparent,
                      ),
                      Column(
                        children: addCaptionActions,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
