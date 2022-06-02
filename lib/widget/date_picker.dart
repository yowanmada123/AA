import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'extention/ext_date.dart';

class OdatePickerAndroid extends StatefulWidget {
  final String title;
  DateTime? date;
  OdatePickerAndroid({Key? key, required this.title, required this.date})
      : super(key: key);

  @override
  State<OdatePickerAndroid> createState() => _OdatePickerAndroidState();
}

class _OdatePickerAndroidState extends State<OdatePickerAndroid> {
//init date

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
              color: Theme.of(context).colorScheme.primary,
            ),
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
                    controller: TextEditingController(
                        text: widget.date?.toDateHuman() ?? ''),
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
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.date ?? DateTime.now(),
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget.date) {
      setState(() {
        widget.date = picked;
      });
    }
  }
}
