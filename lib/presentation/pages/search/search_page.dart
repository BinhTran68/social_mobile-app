import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/form_container_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(132.h),
            child: Container(
              padding: EdgeInsets.only(top: 44.h),
              child:  Padding(
                padding:  EdgeInsets.only(left: 10.w, right: 8.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: FormContainerWidget(
                            startIcon: Icon(Icons.search),
                            hintText: "Search",
                            borderRadius: 10,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: _buildScanAction())
                      ],
                    ),
                    sizeVer(8.h),
                    SizedBox(
                        height: 32.h,
                        width: double.infinity,
                        child: _buildListViewTabMark())
                  ],
                ),
              ) ,
            )),
        body: Container(),
    );
  }
}


Widget _buildHeaderSearchPage() {
  return Container();
}

Widget _buildScanAction() {
  return SizedBox(
      height: 20,
      width: 20,
    child: Image.asset("assets/images/Live.png"),
  );
}

Widget _buildListViewTabMark() {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'R'];

  return ListView.builder(
      itemCount: entries.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: SizedBox(
        height: 32.h,
        width: 75.w,
        child: Center(child: _buildItemTabMark()),
      ),
    );
  });
}

Widget _buildItemTabMark() {
  return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: Colors.grey.shade600)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopify_outlined),
          appTextWidget(text: "IGTV", fontSize: 14.sp, fontWeight: FontWeight.w500)
        ], 
      ),
  );
}