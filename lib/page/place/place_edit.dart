import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/repository/image_repo.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/camera.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/base/map/map_openstreet.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker _picker = ImagePicker();
  bool loading = true;

  double? latitude;
  double? longitude;

  getData() async {
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

      addressController.text = data!['place']['address'];
      imagesController.text = data['place']['images'];
      latitudeController.text = data['place']['latitude'].toString();
      longitudeController.text = data['place']['longitude'].toString();
      nameController.text = data['place']['name'];

      latitude = data['place']['latitude'];
      longitude = data['place']['longitude'];
      log("LATITUDE & LONGITUDE");
      log(latitude.toString());
      log(longitude.toString());
      log("LATITUDE & LONGITUDE 2");

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
      setState(() {
        loading = false;
      });
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
        child: (loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
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
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "UBAH LOKASI",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BaseMapOpenStreet(
                          height: 200,
                          latitude: latitude,
                          longitude: longitude,
                          onChanged: (val) {
                            // setState(() {
                            latitudeController.text = val.latitude.toString();
                            longitudeController.text = val.longitude.toString();
                            addressController.text = val.address;
                            // });
                          },
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
                        Text(
                          "UBAH GAMBAR",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 250,
                          width: double.infinity,
                          child: GestureDetector(
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
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Ingin mengubah gambar ?",
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
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
                                                                Get.back();
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
                                                              }
                                                              Get.back();
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
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Yes ",
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "No ",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: foto(fileIdCard, imagesController.text),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  OButtonBar(
                    title: "UPDATE",
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        await updateData(fileIdCard);
                        // log("valid");
                        // log("nameController.text =${nameController.text}");
                        // log("nameController.text =${imagesController.text}");
                        // log("addressController.text =${addressController.text}");
                        // log("latitudeController.text =${latitudeController.text}");
                        // log("longitudeController.text =${longitudeController.text}");
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> updateData(File? file) async {
    if (file != null) {
      String? filename = await ImageService().image(file);
      imagesController.text = filename!;
      log("OYOY1");
      // log(imagesController.text);
      // log("----------------Image Readed-----------------------");
    }

    String itemID = widget.item.id.toString();
    double latitude = double.parse(latitudeController.text);
    double longitude = double.parse(longitudeController.text);
    // log(latitude.toString());
    // log(longitude.toString());
    // log(itemID);

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
        Get.back();
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}

Widget foto(File? imageFile, String? images) {
  return AspectRatio(
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
        ),
      ),
      child: (imageFile != null)
          ? ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(9),
              ),
              child: Image.file(
                File(imageFile.path),
                fit: BoxFit.cover,
              ),
            )
          : ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(9),
              ),
              child: Image.network(
                "http://103.186.0.33:3000/uploads/$images",
                fit: BoxFit.cover,
              ),
            ),
    ),
  );
}
