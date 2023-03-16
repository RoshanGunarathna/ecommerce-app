import 'package:flutter/material.dart';

import '../../../core/palette.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 10),
            child: TextFormField(
              cursorColor: blackColor,
              onFieldSubmitted: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
                prefixIcon: InkWell(
                  onTap: () {},
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
