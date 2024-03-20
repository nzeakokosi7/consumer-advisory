import 'dart:convert';
import 'dart:io';

import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/features/advisory/presentation/screens/new_advisory_screen.dart';
import 'package:consumable_advisory/features/text_detection/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({
    super.key,
    required this.title,
    this.text,
    required this.onImage,
    required this.onDetectorViewModeChanged,
  });

  final String title;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final Function()? onDetectorViewModeChanged;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  String? _path;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
    _getImage(ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        backgroundColor: AppColors.appBlack,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: widget.onDetectorViewModeChanged,
              child: Icon(
                Platform.isIOS ? Icons.camera_alt_outlined : Icons.camera,
              ),
            ),
          ),
        ],
      ),
      body: _galleryBody(context),
    );
  }

  Widget _changeImageButton(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 150.0,
      child: ListTile(
        horizontalTitleGap: 0,
        leading: const Icon(
          Icons.photo_library_outlined,
          size: 25,
        ),
        title: const Text(
          "Change",
        ),
        onTap: () => _getImage(ImageSource.gallery),
      ),
    );
  }

  Widget _proceedToAdvisoryButton(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 150.0,
      child: ListTile(
        title: const Text(
          "Proceed",
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          size: 25,
        ),
        onTap: () => _goToAdvisory(context),
      ),
    );
  }

  Widget _galleryBody(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (_image != null)
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.file(_image!),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _changeImageButton(context),
                      _proceedToAdvisoryButton(context)
                    ],
                  )
                ],
              ),
            )
          // else
          //   const Icon(
          //     Icons.image,
          //     size: 200,
          //   ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: ElevatedButton(
          //     onPressed: _getImageAsset,
          //     child: const Text('From Assets'),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: ElevatedButton(
          //     child: const Text('From Gallery'),
          //     onPressed: () => _getImage(ImageSource.gallery),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: ElevatedButton(
          //     child: const Text('Take a picture'),
          //     onPressed: () => _getImage(ImageSource.camera),
          //   ),
          // ),
          // if (_image != null)
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Text(
          //         '${_path == null ? '' : 'Image path: $_path'}\n\n${widget.text ?? ''}'),
          //   ),
        ],
      ),
    );
  }

  void _goToAdvisory(BuildContext context) {
    context.push(NewAdvisoryScreen.route, extra: _path);
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      _path = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _getImageAsset() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap =
        json.decode(manifestContent) as Map<String, dynamic>;
    final assets = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) =>
            key.contains('.jpg') ||
            key.contains('.jpeg') ||
            key.contains('.png') ||
            key.contains('.webp'),)
        .toList();

    if (context.mounted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select image',
                      style: TextStyle(fontSize: 20),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.7,),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (final path in assets)
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  _processFile(await getAssetPath(path));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(path),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            );
          },);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    _path = path;
    // final inputImage = InputImage.fromFilePath(path);
    // widget.onImage(inputImage);
  }
}
