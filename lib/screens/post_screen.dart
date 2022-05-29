import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/page_model.dart';
import 'package:houlalaadministrator/widget/post_list.dart';
import 'package:houlalaadministrator/widget/title.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PostScreen extends StatelessWidget {
  final PageModel? pageModel;
  final ScrollController scrollController = ScrollController();

  PostScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        breakpoints: const ScreenBreakpoints(
          desktop: 1280,
          tablet: 728,
          watch: 300,
        ),
        builder: (context, sizingInformation) {
          switch (sizingInformation.deviceScreenType) {
            case DeviceScreenType.mobile:
              return OrientationLayoutBuilder(
                portrait: (BuildContext context) {
                  return MobilePostScreen(
                    pageModel: pageModel,
                    crossAxisCount: 1,
                  );
                },
                landscape: (BuildContext context) {
                  return MobilePostScreen(
                    pageModel: pageModel,
                    crossAxisCount: 2,
                  );
                },
              );
            case DeviceScreenType.tablet:
              return TabletPostScreen(
                pageModel: pageModel,
                crossAxisCount: 3,
              );
            case DeviceScreenType.desktop:
            default:
              return TabletPostScreen(
                pageModel: pageModel,
                crossAxisCount: 4,
              );
          }
        });
  }
}

class MobilePostScreen extends StatelessWidget {
  final PageModel? pageModel;
  final int? crossAxisCount;

  const MobilePostScreen({
    Key? key,
    this.pageModel,
    this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          standardVerticalSpace,
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomTitle(
                  title: "Posts",
                  size: 22.0,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    '/addPost',
                    arguments: pageModel!.id,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      children: const [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Ajouter un post",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          standardVerticalSpace,
          PostLists(
            posts: pageModel!.posts,
            crossAxisCount: crossAxisCount!,
          ),
          standardVerticalSpace,
        ],
      ),
    );
  }
}

class TabletPostScreen extends StatelessWidget {
  final PageModel? pageModel;
  final int? crossAxisCount;

  const TabletPostScreen({
    Key? key,
    this.pageModel,
    this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                standardVerticalSpace,
                const SafeArea(
                  child: CustomTitle(
                    title: "Posts",
                    size: 22.0,
                  ),
                ),
                standardVerticalSpace,
                PostLists(
                  posts: pageModel!.posts,
                  crossAxisCount: crossAxisCount,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            '/addPost',
            arguments: pageModel!.id,
          ),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(5.0)),
            child: const Text("Ajouter un post"),
          ),
        ),
      ),
    );
  }
}
