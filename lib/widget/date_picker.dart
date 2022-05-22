import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OdatePickerAndroid extends StatefulWidget {
  final String title;
  const OdatePickerAndroid({Key? key, required this.title}) : super(key: key);

  @override
  State<OdatePickerAndroid> createState() => _OdatePickerAndroidState();
}

class _OdatePickerAndroidState extends State<OdatePickerAndroid> {
//init date
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(
            height: 6,
          ),
          InkWell(
            // onTap: fungsi,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    validator: (baseValidator) {
                      if (baseValidator == null || baseValidator.isEmpty) {
                        return '${widget.title.toUpperCase()} TIDAK BOLEH KOSONG';
                      }
                      return null;
                    },
                    controller:
                        TextEditingController(text: selectedDate.toString()),
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      hintText: 'Masukkan ${widget.title.capitalizeText()}',
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_outlined)
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Divider(
          //   thickness: 1.5,
          // )
        ],
      ),
    );
    // return Center(
    //   child: OutlinedButton(
    //     onPressed: () {
    //       _selectDate(context);
    //     },
    //     child: const Text('Open Date Picker'),
    //   ),
    // );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
