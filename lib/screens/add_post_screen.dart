import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/custom_button.dart';
import 'package:houlalaadministrator/service/post_service.dart';
import 'package:houlalaadministrator/widget/custom_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../model/add_post.dart';
import '../widget/input_text.dart';
import '../widget/title.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pageId = ModalRoute.of(context)!.settings.arguments as String;
    late XFile? imageFile = Provider.of<PostService>(context).getImageFile();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const CustomTitle(
          title: "Ajouter un Post",
          size: 22.0,
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      body: ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
          switch (sizingInformation.deviceScreenType) {
            case DeviceScreenType.mobile:
              return MobileFormScreen(
                pageId: pageId,
                imageFile: imageFile,
                contentController: _contentController,
              );
            case DeviceScreenType.tablet:
              return FormScreen(
                pageId: pageId,
                imageFile: imageFile,
                contentController: _contentController,
                width: MediaQuery.of(context).size.width * 0.70,
              );
            case DeviceScreenType.desktop:
            default:
              return FormScreen(
                pageId: pageId,
                imageFile: imageFile,
                contentController: _contentController,
                width: MediaQuery.of(context).size.width * 0.45,
              );
          }
        },
      ),
    );
  }
}

class MobileFormScreen extends StatefulWidget {
  final TextEditingController? contentController;
  final XFile? imageFile;
  final String? pageId;

  const MobileFormScreen({
    Key? key,
    this.imageFile,
    this.pageId,
    this.contentController,
  }) : super(key: key);

  @override
  State<MobileFormScreen> createState() => _MobileFormScreenState();
}

class _MobileFormScreenState extends State<MobileFormScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: CustomCard(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        controller: widget.contentController,
                        minLines: 3,
                        maxLines: 6,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      widget.imageFile != null
                          ? SizedBox(
                              height: 200,
                              child: kIsWeb
                                  ? Image.network(
                                      widget.imageFile!.path,
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Image.file(
                                      File(
                                        widget.imageFile!.path,
                                      ),
                                    ),
                            )
                          : Container(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => Provider.of<PostService>(context,
                                      listen: false)
                                  .pickImage(),
                              child: const Icon(Icons.image_outlined),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                              onTap: () async {
                                AddPost newPost = AddPost(
                                    content: widget.contentController!.text,
                                    pageId: widget.pageId);

                                if (widget.imageFile != null) {
                                  await Provider.of<PostService>(context,
                                          listen: false)
                                      .addPostWithImage(
                                          widget.imageFile!, newPost);
                                } else {
                                  await Provider.of<PostService>(context,
                                          listen: false)
                                      .addPostWithoutImage(newPost);
                                }

                                if (!mounted) {
                                  return;
                                }
                                widget.contentController!.clear();

                                Navigator.of(context).pop();
                              },
                              child: const CustomButton(
                                title: "Enregistrer",
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  final String? pageId;
  final TextEditingController? contentController;
  final XFile? imageFile;
  final double? width;

  const FormScreen({
    Key? key,
    this.pageId,
    this.contentController,
    this.imageFile,
    this.width,
  }) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
              width: widget.width,
              child: CustomCard(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        controller: widget.contentController,
                        minLines: 3,
                        maxLines: 6,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      widget.imageFile != null
                          ? SizedBox(
                              height: 200,
                              child: Image.network(
                                widget.imageFile!.path,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => Provider.of<PostService>(context,
                                      listen: false)
                                  .pickImage(),
                              child: const Icon(Icons.image_outlined),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                              onTap: () async {
                                AddPost newPost = AddPost(
                                    content: widget.contentController!.text,
                                    pageId: widget.pageId);

                                if (widget.imageFile != null) {
                                  await Provider.of<PostService>(context,
                                          listen: false)
                                      .addPostWithImage(
                                          widget.imageFile!, newPost);
                                } else {
                                  await Provider.of<PostService>(context,
                                          listen: false)
                                      .addPostWithoutImage(newPost);
                                }

                                if (!mounted) {
                                  return;
                                }
                                widget.contentController!.clear();

                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Text(
                                  "Enregistrer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
