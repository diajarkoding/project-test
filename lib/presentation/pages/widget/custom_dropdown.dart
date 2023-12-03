import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:project_test/utils/theme.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.title,
      required this.icon,
      this.marginTop = 20,
      required this.items,
      this.itemAsString,
      this.dropdownBuilder,
      this.onChanged,
      this.asyncItems});

  final String title;
  final String icon;
  final double marginTop;

  final List items;
  final String Function(dynamic)? itemAsString;
  final Widget Function(BuildContext, dynamic)? dropdownBuilder;
  final void Function(dynamic)? onChanged;
  final Future<List<dynamic>> Function(String)? asyncItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: marginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroudColor2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    icon,
                    width: 17,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: DropdownSearch<dynamic>(
                      popupProps: const PopupProps.menu(
                        fit: FlexFit.loose,
                        searchDelay: Duration(milliseconds: 100),
                        menuProps: MenuProps(
                          backgroundColor: Colors.white,
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration.collapsed(
                          hintText: '',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                      items: items,
                      itemAsString: itemAsString,
                      asyncItems: asyncItems,
                      onChanged: onChanged,
                      dropdownBuilder: dropdownBuilder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
