import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OdatePickeriOS extends StatefulWidget {
  final String title;
  DateTime? date;
  OdatePickeriOS({Key? key, required this.title, required this.date})
      : super(key: key);

  @override
  State<OdatePickeriOS> createState() => _OdatePickeriOSState();
}

class _OdatePickeriOSState extends State<OdatePickeriOS> {
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
                      _showIOS_DatePicker(context);
                    },
                    validator: (baseValidator) {
                      if (baseValidator == null || baseValidator.isEmpty) {
                        return '${widget.title.toUpperCase()} TIDAK BOLEH KOSONG';
                      }
                      return null;
                    },
                    controller:
                        TextEditingController(text: widget.date.toString()),
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

  void _showIOS_DatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 190,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: CupertinoDatePicker(
                        initialDateTime: widget.date,
                        onDateTimeChanged: (val) {
                          setState(() {
                            widget.date = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }
}
