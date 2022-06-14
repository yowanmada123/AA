import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/radio_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'checkbox_filter.dart';
import 'dropdown_filter.dart';

class OFilterList extends StatefulWidget {
  final String title;
  final String icon;
  OFilterList({Key? key, required this.title, required this.icon, 

  })
      : super(key: key);

  @override
  State<OFilterList> createState() => _OFilterListState();
}

class _OFilterListState extends State<OFilterList> {
  List<String> itemDropdown = ["Jakarta", "Surabaya", "Bandung"];

  String dropdownValue = "Jakarta";
  bool accept = false;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: GestureDetector(
          onTap: (){
            if(widget.title == "Filter"){

              ShowFilter(context);
            }else if(widget.title == "Sort By"){
              SortBy(context);        
            }else{
              
            }          
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: OColorBrown,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SvgPicture.asset(widget.icon),
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: OColorBrown),
                    ).fieldTitleText(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ); 
  }

  Future<dynamic> ShowFilter(BuildContext context) {
    return showModalBottomSheet(
      context: context, 
      shape: const RoundedRectangleBorder( // <-- SEE HERE
        borderRadius: BorderRadius.vertical( 
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context){
        return Container( 
          height: 0.4 * MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:18.0, right: 18.0, left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/ic/ic_close.svg")),
                    const Text("Filter", style: TextStyle(color: Color(0xff19204E)),).pageTitleText(),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/ic/ic_tick.svg")),
                  ],
                ),
              ),
              const SizedBox(
                height: 47
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "LOCATION",
                          style:
                              TextStyle(color: Theme.of(context).colorScheme.primary),
                        ).titleText(),
                      ],
                    ),
                    const SizedBox(
                      height: 4
                    ),
                    FDropdown(
                      itemDropdown: itemDropdown,
                      dropdownValue: dropdownValue,
                      onChanged: (val) {
                        setState(() {
                          dropdownValue = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 35
                    ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "PRICE RANGE",
                          style:
                              TextStyle(color: Theme.of(context).colorScheme.primary),
                        ).titleText(),
                      ],
                    ),
                    const SizedBox(
                      height: 4
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 103,
                          height: 24,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 0.5
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 7.0),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 12),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 7
                        ),
                        SvgPicture.asset("assets/ic/ic_strip.svg"),
                        const SizedBox(
                          width: 7
                        ),
                        Container(
                          width: 103,
                          height: 24,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 0.5
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 7.0),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 12),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
              const SizedBox(
                height: 10
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: FCheckBox(
                text:
                    "AVAILABLE TODAY",
                accept: accept,
                fungsi: (val) {
                  setState(() {
                    accept = !accept;
                    print(accept);
                  });
                }),
              ),
            ],
            ),
          )
        );
      },
    );
  }

  Future<dynamic> SortBy(BuildContext context) {  
    String? _groupValue;
  
    ValueChanged<String?> _valueChangedHandler() {
      return (value) => setState(() => _groupValue = value!);
    }
    return showModalBottomSheet(
            context: context, 
            shape: const RoundedRectangleBorder( // <-- SEE HERE
              borderRadius: BorderRadius.vertical( 
                top: Radius.circular(25.0),
              ),
            ),
            builder: (context){
              return Container( 
               height: 0.38 * MediaQuery.of(context).size.height,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("assets/ic/ic_close.svg")),
                      const Text("Sort By", style: TextStyle(color: Color(0xff19204E)),).pageTitleText(),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("assets/ic/ic_tick.svg")),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 47
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:37.0),
                      child: Column(children: [
                        MyRadioOption<String>(
                          value: 'A',
                          groupValue: _groupValue,
                          onChanged: _valueChangedHandler(),
                          label: 'A',
                          text: 'POPULARITY',
                        ),
                        MyRadioOption<String>(
                          value: 'B',
                          groupValue: _groupValue,
                          onChanged: _valueChangedHandler(),
                          label: 'B',
                          text: 'CLOSEST DISTANCE',
                        ),
                        MyRadioOption<String>(
                          value: 'C',
                          groupValue: _groupValue,
                          onChanged: _valueChangedHandler(),
                          label: 'C',
                          text: 'PRICE: HIGH TO LOW',
                        ),
                        MyRadioOption<String>(
                          value: 'D',
                          groupValue: _groupValue,
                          onChanged: _valueChangedHandler(),
                          label: 'D',
                          text: 'PRICE: LOW TO HIGH',
                        ),
                      ],
                    ),
                  ),
                    
                  ],
                 ),
               )
              );
            },
          );
  }
}
