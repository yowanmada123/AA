import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FDropdown extends StatefulWidget {
  final List<String> itemDropdown;
  final String dropdownValue;
  final ValueChanged<String> onChanged;
  const FDropdown({
    Key? key,
    required this.itemDropdown,
    required this.dropdownValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FDropdown> createState() => _FDropdownState();
}

class _FDropdownState extends State<FDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            style: BorderStyle.solid,
            width: 0.80),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 7.0, top: 0),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: widget.dropdownValue,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    elevation: 0,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      widget.onChanged(newValue!);
                    },
                    items: widget.itemDropdown
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
