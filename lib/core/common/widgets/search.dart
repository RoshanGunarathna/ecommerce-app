// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../../palette.dart';

class Search extends StatelessWidget {
  final TextEditingController textEditingController;
  const Search({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  void navigateToSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: textEditingController);
  }

  @override
  Widget build(BuildContext context) {
    bool shouldIGotoSearchScreen = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 10),
            child: TextFormField(
              onChanged: (value) {
                if (shouldIGotoSearchScreen) {
                  navigateToSearchScreen(context);
                }
              },
              controller: textEditingController,
              cursorColor: blackColor,
              onFieldSubmitted: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
                prefixIcon: InkWell(
                  onTap: () => navigateToSearchScreen(context),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 7, right: 8),
                    child: Icon(
                      Icons.search_rounded,
                      color: blackColorShade1,
                      size: 30,
                    ),
                  ),
                ),
                filled: true,
                fillColor: blackColorShade2,
                contentPadding: const EdgeInsets.only(top: 10),
                hintText: 'Search here...',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
                suffixIcon: InkWell(
                  onTap: () {},
                  radius: 10,
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.mic_none_outlined,
                      color: blackColorShade1,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          radius: 10,
          child: Container(
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: primaryColor,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
