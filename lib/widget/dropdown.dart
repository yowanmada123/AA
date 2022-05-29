import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ODropdown extends StatefulWidget {
  final List<String> itemDropdown;
  final String dropdownValue;
  final ValueChanged<String> onChanged;
  const ODropdown(
      {Key? key,
      required this.itemDropdown,
      required this.dropdownValue,
      required this.onChanged})
      : super(key: key);

  @override
  State<ODropdown> createState() => _ODropdownState();
}

class _ODropdownState extends State<ODropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        isExpanded: true,
        value: widget.dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        elevation: 16,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        underline: Container(
          height: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
        onChanged: (String? newValue) {
          widget.onChanged(newValue!);
        },
        items:
            widget.itemDropdown.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
