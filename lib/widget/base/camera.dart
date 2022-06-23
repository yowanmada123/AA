import 'dart:io';

import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CameraOverlay extends StatefulWidget {
  final String jenis;
  const CameraOverlay(this.jenis, {Key? key}) : super(key: key);

  @override
  State<CameraOverlay> createState() => _CameraOverlayState();
}

class _CameraOverlayState extends State<CameraOverlay> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final gstate = Get.put(GlobalController());

  XFile? imageFile;
  CameraController? controller;
  File? file;
  List<CameraDescription> cameras = [];

  initCamera() async {
    // List<CameraDescription> cameras;
    cameras = await availableCameras();
    controller =
        CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color(0x55000000);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(fit: StackFit.expand, children: [
        (controller == null || !controller!.value.isInitialized)
            ? Container()
            : CameraPreview(controller!),
        // cameraOverlay(    padding: 30, aspectRatio: 4 / 3, color: const Color(0x40202B36)),
        (widget.jenis == "identitas")
            ? cameraOverlay(
                padding: 30, aspectRatio: 4 / 3, color: const Color(0x40202B36))
            : cameraOverlayCircle(),
        // (imageFile != null) ? Image.file(File(imageFile!.path)) : Text("img"),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              // iconSize: 50,
            ),
          ),
        ),
        SafeArea(
          child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      (widget.jenis == "identitas")
                          ? "Foto Identitas"
                          : 'Foto Profil',
                    ).titleText().white(),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      (widget.jenis == "identitas")
                          ? "Posisikan Identitas Anda Didalam Bingkai"
                          : 'Posisikan Foto Wajah Anda Didalam Bingkai',
                    ).titleText().white(),
                  ],
                ),
              )),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      onTakePictureButtonPressed();
                    },
                    icon: SvgPicture.asset("assets/ic/ic_capture_camera.svg"),
                    iconSize: 50,
                  ),
                  IconButton(
                    onPressed: () {
                      onNewCameraSelected(
                          (controller!.description == cameras[0])
                              ? cameras[1]
                              : cameras[0]);
                    },
                    icon: Icon(
                      Icons.rotate_left_sharp,
                      color: Colors.white,
                    ),
                    iconSize: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void onTakePictureButtonPressed() {
    showInSnackBar('Picture Capture');
    controller!.takePicture().then((XFile? files) {
      if (mounted) {
        setState(() {
          imageFile = files;
          // file = files.readAsString()
          // videoController?.dispose();
          // videoController = null;
        });
        if (files != null) {
          showInSnackBar('Picture saved to ${files.path}');
          Get.back(result: File(imageFile!.path));
        }
      }
    });
  }

  void _showCameraException(CameraException e) {
    // logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

Widget cameraOverlayCircle() {
  return LayoutBuilder(builder: (context, constraints) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8),
          BlendMode.srcOut), // This one will create the magic
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                backgroundBlendMode: BlendMode
                    .dstOut), // This one will handle background + difference out
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 200, left: 40, right: 40),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  height: double.infinity,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  });
}

Widget cameraOverlay(
    {required double padding,
    required double aspectRatio,
    required Color color}) {
  return LayoutBuilder(builder: (context, constraints) {
    // double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
    double horizontalPadding;
    double verticalPadding;

    // if (parentAspectRatio < aspectRatio) {
    horizontalPadding = padding;
    verticalPadding = (constraints.maxHeight -
            ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
        2;
    // } else {
    // verticalPadding = padding;
    // horizontalPadding = (constraints.maxWidth -
    //         ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
    //     2;
    // }

    return Stack(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Container(width: horizontalPadding, color: color),
          )),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Container(width: horizontalPadding, color: color),
          )),
      Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: EdgeInsets.only(
                  left: horizontalPadding, right: horizontalPadding),
              height: verticalPadding,
              color: color)),
      //set bottom button
      Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Container(
                margin: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                height: verticalPadding,
                color: color),
          )),
      Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(border: Border.all(color: Colors.cyan)),
        ),
      )
    ]);
  });
}
