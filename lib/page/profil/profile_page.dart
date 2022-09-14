import 'package:boilerplate_flutter/page/kyc/kyc_form.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_list.dart';
import 'package:boilerplate_flutter/page/profil/list_user_page.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: 248,
                width: Get.width,
                decoration: BoxDecoration(color: OprimaryColor),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 11,
                    ),
                    const Text("Account").pageTitleText().white(),
                    const SizedBox(
                      height: 16,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child: Icon(
                        Icons.person_outline_outlined,
                        size: 40,
                        color: OprimaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Stephen Strange").pageTitleText().white(),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: BaseButton(
                            ontap: () {},
                            color: Color(0xff19204E),
                            text: "Edit",
                            textColor: Colors.white,
                          )),
                          const SizedBox(
                            width: 11,
                          ),
                          Expanded(
                              child: BaseButton(
                            ontap: () {
                              Get.to(const KYCFormPage());
                            },
                            color: Colors.white,
                            text: "Add Member",
                            textColor: OprimaryColor,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    Get.to(ListUserPage());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 48,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 158, 158, 158),
                          blurRadius: 4,
                          offset: Offset(-3, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/ic/ic_member_check.svg"),
                            const SizedBox(
                              width: 9,
                            ),
                            const Text("Member List ").descriptionText().black(),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 158, 158, 158),
                      blurRadius: 0.1,
                      offset: Offset(-0.1, 0.1), // Shadow position
                    ),
                  ],
                ),
                child: BaseButton(
                  outlineRadius: 0,
                  ontap: () {},
                  color: Colors.white,
                  textColor: const Color(0xff99A4AB),
                  text: "Log out",
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          )
        ]),
      ),
    );
  }
}
