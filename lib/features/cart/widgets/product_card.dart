// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/palette.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final VoidCallback onPressedDelete;
  final bool isDeleteButtonPresed;

  const ProductCard({
    Key? key,
    required this.image,
    required this.onPressedDelete,
    required this.isDeleteButtonPresed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: blackColorShade2,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Image.network(
                    image,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tomatoes',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '\$ 6.00',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text('+'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          alignment: Alignment.center,
                          height: 18,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            '1kg',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: whiteColor,
                          ),
                          child: const Text('-'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            isDeleteButtonPresed
                ? Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      child: Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.delete_outline_outlined,
                          color: whiteColor,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: onPressedDelete,
                        icon: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey, width: 1.7),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
