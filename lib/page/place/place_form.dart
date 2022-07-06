import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/images_res.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/region/region_list.dart';
import 'package:boilerplate_flutter/repository/image_repo.dart';
import 'package:boilerplate_flutter/repository/ocr_passport_repo.dart';
import 'package:boilerplate_flutter/repository/orc_ktp_repo.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/button/button_choose_place.dart';
import 'package:boilerplate_flutter/widget/base/camera.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/base/form/form_text.dart';
import 'package:boilerplate_flutter/widget/base/map/map_openstreet.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import "package:http/http.dart" as HttpMultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

import '../../model/user/profile.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({Key? key}) : super(key: key);

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  File? fileIdCard;
  File? filePhoto;
  Uint8List webImageCard = Uint8List(10);
  Uint8List webImagePhoto = Uint8List(10);
  bool isHaveImageCard = false;
  bool isHaveImageID = false;

  final gstate = Get.put(GlobalController());

  TextEditingController addressController = TextEditingController();
  //images
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController regionIdController = TextEditingController();
  TextEditingController langtitudeController = TextEditingController();
  TextEditingController longtitudeController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool isButtonLoading = false;

  String jenisIdentitas = "PASSPORT";

  final ImagePicker _picker = ImagePicker();
  late String placeValue = "Jakarta";
  TextEditingController alamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buat Tempat Baru").pageTitleText()),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Masukkan Detail Informasi Terkait Lokasi").titleText(),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text("Pastikan Anda sudah memasukkan semua data dengan tepat terkait informasi lokasi untuk dapat melakukan proses pembuatan lokasi baru").descriptionText(),
                    const SizedBox(
                      height: 6,
                    ),
                    OFormText(
                      title: "NAMA TEMPAT",
                      controller: nameController,
                    ),
                    OFormText(
                      title: "DESKRIPSI",
                      controller: descriptionController,
                    ),
                    const Text("Upload foto terkait lokasi yang dapat dilihat dengan jelas oleh para pengunjung").descriptionText(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () async {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (c) => AlertDialog(
                                    title: Container(),
                                    content: Container(
                                      color: Colors.white,
                                      height: 80,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              File? file = await Get.to(() => const CameraOverlay('identitas'));
                                              if (file != null) {
                                                setState(() {
                                                  fileIdCard = file;
                                                });
                                                imageReader(file);
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Kamera",
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                              if (image != null) {
                                                setState(() {
                                                  fileIdCard = File(image.path);
                                                });
                                                imageReader(fileIdCard!);
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Galeri"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: foto(fileIdCard, gstate)),
                        ),
                      ],
                    ),
                    Text(
                      "PILIH REGION",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ButtonChoosePlace(
                      placeValue: placeValue,
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegionListPage()),
                        );
                        if (result != null) {
                          setState(() {
                            placeValue = result.name;
                          });
                        }
                        // print(result);
                        regionIdController.text = result.id;
                        // print(regionIdController.text);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "TENTUKAN LOKASI",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
                    ),
                    OFormText(
                      title: "LONGTITUDE",
                      controller: langtitudeController,
                    ),
                    OFormText(
                      title: "LANGTITUDE",
                      controller: longtitudeController,
                    ),
                  ],
                ),
              ),
              OButtonBar(
                title: "LANJUT",
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    if (fileIdCard == null) {
                      Alertx().error("Foto tempat belum ada");
                    } else if (filePhoto == null) {
                      Alertx().error("Foto tempat belum ada");
                    } else {
                      await SaveData();
                    }
                    log("valid");
                    log("addressController.text =${addressController.text}");
                    log("nameController.text =${nameController.text}");
                    log("descriptionController.text=${descriptionController.text}");
                    log("regionIdController.text=${regionIdController.text}");
                    log("langtitudeController.text=${langtitudeController.text}");
                    log("longtitudeController.text=${longtitudeController.text}");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  imageReader(File file) async {
    ImageRes? imageResponse = await ImageService().image(file);
    if (imageResponse != null) {
      imageController.text = imageResponse.filename;
    }
    log('imageResponse');
  }

  Future<void> SaveData() async {
    var imageKtp = await fileIdCard!;
    var imageProfil = await filePhoto!;

    var b = await HttpMultipartFile.MultipartFile.fromPath(
      'imageProfil',
      imageProfil.path,
      contentType: MediaType("image", "jpeg"),
    );

    var b2 = await HttpMultipartFile.MultipartFile.fromPath(
      'imageProfil',
      imageKtp.path,
      contentType: MediaType("image", "jpeg"),
    );

    String optionPlace = '''
      mutation createPlaces{
          createProfile(
            input: {
              address: "${addressController.text}"
              images: "${imageController.text}"
              name: "${nameController.text}"
              description: "${descriptionController.text}"
              region_id: "${regionIdController.text}"
              latitude: "${langtitudeController.text}"
              longitude: "${longtitudeController.text}"
            }
          ) {
            __typename
            ... on Place{
              address
              images
              description
              name
              distance
              description
              latitude
              longitude
            }
            ... on Error{
              message
            }
          }
        }

      ''';

    try {
      bool isSuccess = false;
      // if (gstate.dataUser.value.name == '') {

      Map<String, dynamic>? dataPlace = await GraphQLBase().mutate(optionPlace,);
      log(dataPlace.toString());

      // if (dataPlace!['addProfile']['__typename'] != 'Error') {
      //   isSuccess = true;
      // } else {
      //   Alertx().error(dataUser['addProfile']['message']);
      // }

      // if (isSuccess) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Data Berhasil Disimpan')),
      // );
      // Get.offAll(SuccesPage());
      // Get.back();
      // }

      // }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}

Widget foto(File? imageFile, GlobalController gstate) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(
              color: Colors.black38, // red as border color
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(9),
            )),
        child: (imageFile != null)
            ? Image.file(
                File(imageFile.path),
                fit: BoxFit.cover,
              )
            : Column(
                children: [
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      "assets/ic/ic_camera.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Ambil Foto",
                  ).titleText(),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              )),
  );
}
