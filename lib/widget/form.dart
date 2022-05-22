import 'package:boilerplate_flutter/widget/extention/ext_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum FormType { text, email, phone, password, money, multiLine }

class OFormText extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final bool isRequired;
  final FormType formType;
  final int maxLines;
  final bool readOnly;

  const OFormText({
    Key? key,
    required this.title,
    this.controller,
    this.isRequired = true,
    this.formType = FormType.text,
    this.hintText,
    this.maxLines = 1,
    this.readOnly = false,
  }) : super(key: key);

  String? checkValidation(String value) {
    if (isRequired) {
      if (value.isEmpty) {
        return '${title.toUpperCase()} TIDAK BOLEH KOSONG';
      }
    }
    if (formType == FormType.phone) {
      if (int.tryParse(value) == null) {
        return '${title.toUpperCase()} HANYA ANGKA SAJA';
      }
    }
    if (formType == FormType.email) {
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (value.trim().isNotEmpty && !regex.hasMatch(value.trim())) {
        return '${title.toUpperCase()} HARUS VALID EMAIL';
      }
    }
    return null;
  }

  List<TextInputFormatter>? maskFormat(FormType type) {
    if (type == FormType.phone) {
      return [
        MaskTextInputFormatter(
          mask: '#### #### #### ##',
          filter: {"#": RegExp(r'[0-9]')},
        )
      ];
    } else if (type == FormType.money) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    bool obscureText = false;
    if (formType == FormType.password) obscureText = true;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary),
          ),
          TextFormField(
            readOnly: readOnly,
            maxLines: maxLines,
            validator: (value) => checkValidation(value!),
            controller: controller,
            keyboardType: textInputType(formType),

            // inputFormatters: maskFormat(formType),
            decoration: InputDecoration(
              // border: InputBorder.none,
              hintText: hintText ?? 'Masukkan ${title.capitalizeText()}',
              // hintStyle: TextStyle(fontSize: gstate.bodyTextSize)
              suffixIcon: (formType == FormType.password)
                  ? InkWell(
                      child: Icon((obscureText)
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onTap: () => obscureText = !obscureText,
                    )
                  : SizedBox.shrink(),
            ),
            obscureText: obscureText,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextInputType textInputType(FormType formType) {
    if (formType == FormType.multiLine) {
      return TextInputType.multiline;
    } else if (formType == FormType.phone) {
      return TextInputType.number;
    } else if (formType == FormType.money) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }
}
