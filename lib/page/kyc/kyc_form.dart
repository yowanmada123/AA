import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_form_controller.dart';
import 'package:boilerplate_flutter/repository/orc_ktp_repo.dart';
import 'package:boilerplate_flutter/widget/alertx.dart';
import 'package:boilerplate_flutter/widget/base_camera.dart';
import 'package:boilerplate_flutter/widget/button_bar.dart';
import 'package:boilerplate_flutter/widget/date_picker.dart';
import 'package:boilerplate_flutter/widget/dropdown.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import "package:http/http.dart" as HttpMultipartFile;
import 'package:http_parser/http_parser.dart';

import '../../model/ocr_res.dart';

class KYCFormPage extends StatefulWidget {
  const KYCFormPage({Key? key}) : super(key: key);

  @override
  State<KYCFormPage> createState() => _KYCFormPageState();
}

class _KYCFormPageState extends State<KYCFormPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  File? fileIdCard;
  File? filePhoto;
  Uint8List webImageCard = Uint8List(10);
  Uint8List webImagePhoto = Uint8List(10);
  bool isHaveImageCard = false;
  bool isHaveImageID = false;

  final gstate = Get.put(GlobalController());
  final kycState = Get.put(KycFormController());

  TextEditingController identityNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String genderController = "";
  // String birthDateController = "";
  String birthDateControllerDisplay = "";
  DateTime birthDateController = DateTime.now();
  // List<CountryModel> dataNegara = [];
  bool isButtonLoading = false;

  List<String> itemDropdown = ["PASSPORT", "KTP", "KK"];
  String jenisIdentitas = "PASSPORT";

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lengkapi Profil").pageTitleText()),
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
                  Text("Masukkan Detail Informasi Anda Sendiri").titleText(),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Pastikan Anda sudah memasukkan semua data untuk dapat melanjutkan proses verifikasi serta data yang Anda masukkan sesuai dengan yang tertulis di kartu identitas")
                      .descriptionText(),
                  SizedBox(
                    height: 6,
                  ),
                  OFormText(
                    title: "NOMOR HANDPHONE",
                    controller: phoneNumberController,
                  ),
                  // Obx(() => BasePilihField(
                  //       isi: kycState.registerNegara.value.toString(),
                  //       title: "KEWARGANEGARAAN",
                  //       fungsi: () async {
                  //         kycState.dataCariNegara.addAll(dataNegara);
                  //         bottomSheetWidget(
                  //             context: context,
                  //             child: CountryOption(
                  //               countries: dataNegara,
                  //             ));
                  //       },
                  //     )),
                  ODropdown(
                    title: 'IDENTITAS',
                    itemDropdown: itemDropdown,
                    dropdownValue: jenisIdentitas,
                    onChanged: (val) {
                      setState(() {
                        jenisIdentitas = val;
                      });
                    },
                  ),
                  // Obx(() => BasePilihField(
                  //       isi: kycState.registerIdentitas.value.toString(),
                  //       title: "JENIS IDENTITAS",
                  //       fungsi: () {
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return IndentityOption().show();
                  //           },
                  //         );
                  //       },
                  //     )),
                  Text("Upload foto identitas beserta foto diri harus terlihat jelas")
                      .descriptionText(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "FOTO IDENTITAS",
                      ).titleText(),
                      Text(
                        "FOTO PROFIL",
                      ).titleText(),
                    ],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            File? file = await Get.to(() =>
                                                CameraOverlay('identitas'));
                                            if (file != null) {
                                              setState(() {
                                                fileIdCard = file;
                                              });
                                              ocr(file);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Kamera",
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            final XFile? image =
                                                await _picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image != null) {
                                              setState(() {
                                                fileIdCard = File(image.path);
                                              });
                                              ocr(fileIdCard!);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Galeri"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );

                              // Get.to(() => CameraExampleHome());
                            },
                            child: foto(fileIdCard, gstate)),
                      ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            File? file = await Get.to(
                                                () => CameraOverlay('profil'));
                                            if (file != null) {
                                              setState(() {
                                                filePhoto = file;
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Kamera",
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            final XFile? image =
                                                await _picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image != null) {
                                              setState(() {
                                                filePhoto = File(image.path);
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Galeri"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: foto(filePhoto, gstate)),
                      ),
                    ],
                  ),
                  OFormText(
                    title: "NAMA LENGKAP",
                    controller: nameController,
                  ),
                  OFormText(
                    title: "NOMOR IDENTITAS",
                    controller: identityNumberController,
                  ),
                  OFormText(
                    title: "KOTA TEMPAT LAHIR",
                    controller: birthPlaceController,
                  ),
                  OdatePickerAndroid(
                      title: "TANGGAL LAHIR", date: birthDateController),
                  // BasePilihField(
                  //   title: "Tanggal Lahir",
                  //   isi: birthDateControllerDisplay,
                  //   fungsi: () async {
                  //     var date = await DatePicker.showSimpleDatePicker(context,
                  //         initialDate: DateTime(1994),
                  //         firstDate: DateTime(1960),
                  //         lastDate: DateTime(2021),
                  //         dateFormat: "dd-MMM-yyyy",
                  //         locale: DateTimePickerLocale.en_us,
                  //         looping: true,
                  //         itemTextStyle: TextStyle(
                  //           color: Color(primaryDark),
                  //         ));
                  //     setState(() {
                  //       birthDateControllerDisplay = date!.toDate().toString();
                  //       birthDateController = date.toyyyyMMdd().toString();
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "JENIS KELAMIN",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                genderController = "L";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Color(blueLight),
                                  color: (genderController == "L")
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onPrimary,
                                  border: Border.all(
                                    color: Colors.grey, // red as border color
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(9),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: (genderController == "L")
                                        ? Text(
                                            "laki-Laki",
                                            // textAlign: TextAlign.center,
                                          ).descriptionText().white()
                                        : Text(
                                            "laki-Laki",
                                            // textAlign: TextAlign.center,
                                          ).descriptionText().black()),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                genderController = "P";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: (genderController == "P")
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onPrimary,
                                  border: Border.all(
                                    color: Colors.grey, // red as border color
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(9),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: (genderController == "P")
                                        ? Text(
                                            "Perempuan",
                                            // textAlign: TextAlign.center,
                                          ).descriptionText().white()
                                        : Text(
                                            "Perempuan",
                                            // textAlign: TextAlign.center,
                                          ).descriptionText().black()),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  OFormText(
                    title: "ALAMAT LENGKAP",
                    controller: addressController,
                  ),
                  OFormText(
                    title: "ALAMAT EMAIL",
                    controller: emailController,
                  ),
                ],
              ),
            ),
            OButtonBar(
              title: "LANJUT",
              onPressed: () async {
                // Get.to(Home());
                if (_key.currentState!.validate()) {
                  if (fileIdCard == null) {
                    Alertx().error("Foto identitas belum ada");
                  } else if (filePhoto == null) {
                    Alertx().error("Foto profil belum ada");
                  } else if (genderController == "") {
                    Alertx().error("Pilih Jenis Kelamin");
                  } else {
                    await SaveData();
                  }
                  log("valid");
                  log("identityNumberController.text =${identityNumberController.text}");
                  log("identityTypeController.text =${jenisIdentitas.toString()}");
                  log("nameController.text =${nameController.text}");
                  log("genderController =$genderController");
                  log("birthDateController.text =${birthDateController}");
                  log("birthPlaceController.text =${birthPlaceController.text}");
                  log("emailController.text =${emailController.text}");
                  log("phoneNumberController.text =${phoneNumberController.text}");
                  log("addressController.text =${addressController.text}");
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

  ocr(File file) async {
    OcrRes? ocr = await OcrService().ktp(file);
    if (ocr != null) {
      setState(() {
        nameController.text = ocr.name;
        birthPlaceController.text = ocr.birthPlace;
        addressController.text = ocr.address;
        identityNumberController.text = ocr.identityNumber;
        // birthDateController = DateTime.tryParse(ocr.birthDate)!;
      });
      log('ocr');
    }
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

    var identityType = jenisIdentitas.toString();
    var gender = genderController;

    String optionsPerson = '''
      mutation createProfile(\$identityPhoto:ImageFile!,\$profilePhoto:ImageFile!) {
          createProfile(
            input: {
              address: "${addressController.text}"
              dateOfBirth: "$birthDateController"
              email: "${emailController.text.replaceAll(' ', '').trim()}"
              fullname: "${nameController.text}"
              gender: $gender
              identityNumber: "${identityNumberController.text}"
              identityType: $identityType
              phone: "${phoneNumberController.text.replaceAll(' ', '').trim()}"
              placeOfBirth: "${birthPlaceController.text}"
              profileType: PRIMARY
            }
            identityPhoto: \$identityPhoto
            profilePhoto: \$profilePhoto
          ) {
            __typename
            ... on Profile {
              id
            }
            ... on Error {
              message
            }
          }
        }

      ''';

    Map<String, dynamic> variables = {"identityPhoto": b, "profilePhoto": b2};

    try {
      bool isSuccess = false;
      // if (gstate.dataUser.value.name == '') {

      Map<String, dynamic>? dataUser =
          await GraphQLBase().mutate(optionsPerson, variables: variables);
      log(dataUser.toString());
      // if (dataUser!['addProfile']['__typename'] != 'Error') {
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
