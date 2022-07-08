import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/repository/ocr_passport_repo.dart';
import 'package:boilerplate_flutter/repository/orc_ktp_repo.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/camera.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/base/form/form_date_picker.dart';
import 'package:boilerplate_flutter/widget/base/form/form_dropdown.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import "package:http/http.dart" as HttpMultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

import '../../model/ocr_res.dart';
import '../../model/user/profile.dart';

class UpdatePlacePage extends StatefulWidget {
  final Place item;
  const UpdatePlacePage({Key? key, required this.item}) : super(key: key);

  @override
  State<UpdatePlacePage> createState() => _UpdatePlacePageState();
}

class _UpdatePlacePageState extends State<UpdatePlacePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  File? fileIdCard;
  File? filePhoto;
  Uint8List webImageCard = Uint8List(10);
  Uint8List webImagePhoto = Uint8List(10);
  bool isHaveImageCard = false;
  bool isHaveImageID = false;

  final gstate = Get.put(GlobalController());

  TextEditingController addressController = TextEditingController();
  TextEditingController imagesController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String genderController = "";
  // String birthDateController = "";
  String birthDateControllerDisplay = "";
  DateTime birthDateController = DateTime.now();
  // List<CountryModel> dataNegara = [];
  bool isButtonLoading = false;

  List<String> itemDropdown = ["PASSPORT", "KTP", "KK"];
  String jenisIdentitas = "PASSPORT";

  final ImagePicker _picker = ImagePicker();
  final place = <Place>[].obs;
  final loading = true.obs;

  getData() async {
    // print(widget.item.id);
    String itemId = widget.item.id;

    String options = '''
    query place{
  place(
    id: "$itemId" ) 
  {
    address
    description
    distance
    id
    image_path
    images
    latitude
    longitude
    name
    images
    products(filter: {}, sorting: []) {
      createdAt
      description
      id
      name
      place{
        address
        description
      }
      price
      schedules(filter: {}, sorting: []){
        createdAt
        dayname
      }
    }
    region {
      id
      name
      places(filter: {}, sorting: []){
        address
        description
        
      }
      type
    }
  }
}
    ''';
    try {
      bool isSuccess = false;
      Map<String, dynamic>? data = await GraphQLBase().query(options);
      log(data.toString());
      // log(data!['place']['address']);

      double latitude = data!['place']['latitude'];

      addressController.text = data!['place']['address'];
      imagesController.text = data['place']['images'];
      latitudeController.text = data!['place']['latitude'].toString();
      longitudeController.text = data!['place']['longitude'].toString();
      nameController.text = data['place']['name'];

      if (data != null) {
        isSuccess = true;
      } else {
        Alertx().error("Error");
      }
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data Berhasil Ditampilkan ')),
        );
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Place").pageTitleText()),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Update Informasi ").titleText(),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text("Pastikan Anda sudah mengisikan data terupdate terkait lokasi").descriptionText(),
                  const SizedBox(
                    height: 6,
                  ),
                  OFormText(
                    title: "NAMA TEMPAT",
                    controller: nameController,
                  ),
                  OFormText(
                    title: "ALAMAT LOKASI",
                    controller: addressController,
                  ),
                  OFormText(
                    title: "LATITUDE",
                    controller: latitudeController,
                  ),
                  OFormText(
                    title: "LONGTITUDE",
                    controller: longitudeController,
                  ),
                  OFormText(
                    title: "IMAGE",
                    controller: imagesController,
                  ),
                  // OFormText(
                  //   title: "ALAMAT LOKASI",
                  //   controller: addressController,
                  // ),

                  // const Text("Upload foto identitas beserta foto diri harus terlihat jelas").descriptionText(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     const Text(
                  //       "FOTO IDENTITAS",
                  //     ).titleText(),
                  //     const Text(
                  //       "FOTO PROFIL",
                  //     ).titleText(),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: InkWell(
                  //           onTap: () async {
                  //             showDialog(
                  //               barrierDismissible: true,
                  //               context: context,
                  //               builder: (c) => AlertDialog(
                  //                 title: Container(),
                  //                 content: Container(
                  //                   color: Colors.white,
                  //                   height: 80,
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       InkWell(
                  //                         onTap: () async {
                  //                           Navigator.pop(context);
                  //                           File? file = await Get.to(() => const CameraOverlay('identitas'));
                  //                           if (file != null) {
                  //                             setState(() {
                  //                               fileIdCard = file;
                  //                             });
                  //                             if (jenisIdentitas == "KTP") {
                  //                               print("KTP KTP KTP");
                  //                               ocr(file);
                  //                             } else {
                  //                               ocrPassport(file);
                  //                               print("PASSPORT PASSPORT PASSPORT");
                  //                             }
                  //                           }
                  //                         },
                  //                         child: const Padding(
                  //                           padding: EdgeInsets.all(8.0),
                  //                           child: Text(
                  //                             "Kamera",
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () async {
                  //                           Navigator.pop(context);
                  //                           final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  //                           if (image != null) {
                  //                             setState(() {
                  //                               fileIdCard = File(image.path);
                  //                             });
                  //                             if (jenisIdentitas == "KTP") {
                  //                               print("KTP KTP KTP");
                  //                               ocr(fileIdCard!);
                  //                             } else {
                  //                               ocrPassport(fileIdCard!);
                  //                               print("PASSPORT PASSPORT PASSPORT");
                  //                             }
                  //                           }
                  //                         },
                  //                         child: const Padding(
                  //                           padding: EdgeInsets.all(8.0),
                  //                           child: Text("Galeri"),
                  //                         ),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );

                  //             // Get.to(() => CameraExampleHome());
                  //           },
                  //           child: foto(fileIdCard, gstate)),
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: InkWell(
                  //           onTap: () async {
                  //             showDialog(
                  //               barrierDismissible: true,
                  //               context: context,
                  //               builder: (c) => AlertDialog(
                  //                 title: Container(),
                  //                 content: Container(
                  //                   color: Colors.white,
                  //                   height: 80,
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       InkWell(
                  //                         onTap: () async {
                  //                           Navigator.pop(context);
                  //                           File? file = await Get.to(() => CameraOverlay('profil'));
                  //                           if (file != null) {
                  //                             setState(() {
                  //                               filePhoto = file;
                  //                             });
                  //                           }
                  //                         },
                  //                         child: const Padding(
                  //                           padding: EdgeInsets.all(8.0),
                  //                           child: Text(
                  //                             "Kamera",
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () async {
                  //                           Navigator.pop(context);
                  //                           final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  //                           if (image != null) {
                  //                             setState(() {
                  //                               filePhoto = File(image.path);
                  //                             });
                  //                           }
                  //                         },
                  //                         child: const Padding(
                  //                           padding: EdgeInsets.all(8.0),
                  //                           child: Text("Galeri"),
                  //                         ),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //           child: foto(filePhoto, gstate)),
                  //     ),
                  //   ],
                  // ),
                  // OFormText(
                  //   title: "ALAMAT LENGKAP",
                  //   controller: addressController,
                  // ),
                  // OFormText(
                  //   title: "ALAMAT EMAIL",
                  //   controller: imagesController,
                  // ),
                ],
              ),
            ),
            OButtonBar(
              title: "UPDATE",
              onPressed: () async {
                // Get.to(Home());
                if (_key.currentState!.validate()) {
                  await updateData();
                  // if (fileIdCard == null) {
                  //   Alertx().error("Foto identitas belum ada");
                  // } else if (filePhoto == null) {
                  //   Alertx().error("Foto profil belum ada");
                  // } else if (genderController == "") {
                  //   Alertx().error("Pilih Jenis Kelamin");
                  // } else {
                  //   await updateData();
                  // }
                  log("valid");
                  log("nameController.text =${nameController.text}");
                  log("addressController.text =${addressController.text}");
                  log("latitudeController.text =${latitudeController.text}");
                  log("longitudeController.text =${longitudeController.text}");

                  // log("birthDateController.text =${birthDateController}");
                  // log("birthPlaceController.text =${birthPlaceController.text}");
                  // log("emailController.text =${emailController.text}");
                  // log("phoneNumberController.text =${phoneNumberController.text}");

                }
              },
              // color: Color(primaryDark),
              // textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // ocr(File file) async {
  //   Profile? ocr = await OcrService().ktp(file);
  //   if (ocr != null) {
  //     setState(() {
  //       nameController.text = ocr.fullname;
  //       birthPlaceController.text = ocr.placeOfBirth;
  //       addressController.text = ocr.address;
  //       identityNumberController.text = ocr.identityNumber;
  //       try {
  //         try {
  //           var dateTime2 = DateFormat('dd-MM-yyyy').parse(ocr.dateOfBirth);
  //           birthDateControllerDisplay = dateTime2.toDateHuman();
  //           birthDateController = dateTime2;
  //         } catch (e) {}

  //         if (ocr.gender.toLowerCase() == "male") {
  //           genderController = "L";
  //         } else if (ocr.gender.toLowerCase() == "female") {
  //           genderController = "P";
  //         }
  //         if (ocr.gender.toLowerCase() == "laki - laki") {
  //           genderController = "L";
  //         } else if (ocr.gender.toLowerCase() == "perempuan") {
  //           genderController = "P";
  //         }
  //       } catch (e) {}
  //     });
  //     log('ocr');
  //   }
  // }

  // ocrPassport(File file) async {
  //   Profile? ocr = await OcrPassportService().passport(file);
  //   if (ocr != null) {
  //     setState(() {
  //       nameController.text = ocr.fullname;
  //       birthPlaceController.text = ocr.placeOfBirth;
  //       addressController.text = ocr.address;
  //       identityNumberController.text = ocr.identityNumber;

  //       try {
  //         try {
  //           var dateTime2 = DateFormat('dd-MM-yyyy').parse(ocr.dateOfBirth);
  //           birthDateControllerDisplay = dateTime2.toDateHuman();
  //           birthDateController = dateTime2;
  //         } catch (e) {}

  //         if (ocr.gender.toLowerCase() == "male") {
  //           genderController = "L";
  //         } else if (ocr.gender.toLowerCase() == "female") {
  //           genderController = "P";
  //         }
  //         if (ocr.gender.toLowerCase() == "laki - laki") {
  //           genderController = "L";
  //         } else if (ocr.gender.toLowerCase() == "perempuan") {
  //           genderController = "P";
  //         }
  //       } catch (e) {}
  //     });
  //     log('ocr');
  //   }
  // }

  Future<void> updateData() async {
    // var imageKtp = await fileIdCard!;
    // var imageProfil = await filePhoto!;

    // var b = await HttpMultipartFile.MultipartFile.fromPath(
    //   'imageProfil',
    //   imageProfil.path,
    //   contentType: MediaType("image", "jpeg"),
    // );

    // var b2 = await HttpMultipartFile.MultipartFile.fromPath(
    //   'imageProfil',
    //   imageKtp.path,
    //   contentType: MediaType("image", "jpeg"),
    // );

    // var identityType = jenisIdentitas.toString();
    // var gender = genderController;
    String itemID = widget.item.id.toString();
    int latitude = int.parse(latitudeController.text);
    int longitude = int.parse(longitudeController.text);
    log(latitude.toString());
    String optionsPerson = '''
      mutation updateOnePlace{
  updateOnePlace(
    input: {
      id: "$itemID"
      update: {
        address: "${addressController.text}"
        images: "${imagesController.text}"
        latitude: $latitude
        longitude: $longitude
        name: "${nameController.text}"
        
      }
    }
  ) {
    address
    description
    distance
    id
    image_path
    images
    latitude
    longitude
    name
    products(filter: {}, sorting: []) {
      createdAt
      description
      id
      name
      place{
        address
        description
      }
      price
      schedules(filter: {}, sorting: []){
        createdAt
        dayname
      }
    }
    region {
      id
      name
      places(filter: {}, sorting: []){
        address
        description
      }
      type
    }
  }
}

      ''';

    // Map<String, dynamic> variables = {"identityPhoto": b, "profilePhoto": b2};

    try {
      bool isSuccess = false;
      Map<String, dynamic>? place = await GraphQLBase().mutate(optionsPerson);
      log(place.toString());
      if (place!['updateOnePlace']['address'] != null) {
        isSuccess = true;
      } else {
        Alertx().error("Update Fail");
      }
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data Berhasil di Update')),
        );
        // Get.offAll(SuccesPage());
        Get.back();
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}

Widget foto(File? imageFile, GlobalController gstate) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
          width: double.infinity,
          height: double.infinity,
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
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Ambil Foto",
                    ).titleText(),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                )),
    ),
  );
}
