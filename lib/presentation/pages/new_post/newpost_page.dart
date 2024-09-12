import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:instagram_app/app/helpers.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/icon_widget/overlay_loading.dart';
import 'package:instagram_app/presentation/widgets/new_post_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  List<AssetEntity> images = [];
  final selectedImages = <Map<String, dynamic>>[];
  final indexSelectedList = <int>[];
  final indexSelectedStack = [];


  @override
  void initState() {
    _loadImages();
    super.initState();
  }

  Future<void> _loadImages() async {
    bool storagePermission = false;
    final deviceInfo =await Helpers.checkAndroidInfo();
    if(deviceInfo.version.sdkInt < 33) {
      storagePermission =   await Helpers.requestPermission(Permission.storage);
    }else {
      await Helpers.requestPermissionMediaLibrary();
      storagePermission = true;
    }
    if (storagePermission) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      if (albums.isNotEmpty) {
        final List<AssetEntity> imageList = await albums[0]
            .getAssetListPaged(page: 0, size: 10000); // Lấy 10.000 ảnh đầu tiên
        setState(() {
          images = imageList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newPostAppBar(context,
          isDisable: selectedImages.isEmpty,
          handleOnNext: () {
        Navigator.pushNamed(context, PageConst.newPostAddCaptionPage,arguments: selectedImages);
      }),
      body: Column(
        children: [
          Expanded(
              child:
              selectedImages.isNotEmpty ?
              CarouselSlider(
              items: selectedImages
                  .map((item) => Center(
                  child: Image.memory(
                    item['bytes'],
                    width: double.infinity,
                    fit: BoxFit.contain,
                  )))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                animateToClosest: true,
                enlargeCenterPage: false,
                // autoPlay: true,
              )) :  Image.asset("assets/images/Image-add-02.png", width: 200, height: 200,),
          ),
          Expanded(
            child: images.isEmpty
                ? const Center(child: OverlayLoading())
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<Uint8List?>(
                        future: images[index].thumbnailData,
                        builder: (context, snapshot) {
                          final bytes = snapshot.data;
                          if (bytes == null) {
                            return const OverlayLoading();
                          }
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if(indexSelectedList.contains(index)) {
                                  indexSelectedList.remove(index);
                                  selectedImages.removeWhere((element) => element['index'] == index);
                                }else {
                                  Map<String, dynamic> mapImageSelected = {
                                    "index" : index,
                                    "bytes" : bytes
                                  };
                                  selectedImages.add(mapImageSelected);
                                  indexSelectedList.add(index);
                                }
                              });
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.memory(bytes,
                                    fit: BoxFit.cover),
                                  indexSelectedList.contains(index) ? Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child:  Center(
                                          child: appTextWidget(
                                              textAlign: TextAlign.center,
                                              text: "${indexSelectedList.indexOf(index) + 1}",
                                              color: Colors.black),
                                        ),
                                      )) : const SizedBox.shrink()
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
