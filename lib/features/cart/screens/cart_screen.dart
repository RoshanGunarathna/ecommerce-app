import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../payment/screens/payment_screen.dart';
import '../services/image_services.dart';
import '../widgets/product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<String> images = [];
  final stickyKey = GlobalKey();
  final List<int> deleteReadyList = [];

  void getImages() async {
    final ImageServices imageServices = ImageServices();
    final List<String> imgUrl = await imageServices.getRandomImages();

    images.addAll(imgUrl);
    setState(() {
      images;
    });
  }

  @override
  void initState() {
    getImages();
    super.initState();
  }

  void navigateToBack(BuildContext context) {
    Navigator.pop(context);
  }

  void addToDeleteReadyList(int index) {
    deleteReadyList.add(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var fontSize = const TextStyle(fontSize: 15);
    print(images.length);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigateToBack(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: blackColorShade1,
            size: 35,
          ),
        ),
        title: const Text(
          "Cart",
          style: TextStyle(
              color: blackColorShade1,
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height * 0.6),
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final image = images[index];
                    final bool isDeleteButtonPressed =
                        deleteReadyList.contains(index);

                    return GestureDetector(
                      onTap: () {},
                      child: ProductCard(
                        image: image,
                        onPressedDelete: () {
                          addToDeleteReadyList(index);
                        },
                        isDeleteButtonPresed: isDeleteButtonPressed,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Items (2)',
                            style: fontSize,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Discount',
                            style: fontSize,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Shipping', style: fontSize),
                        ],
                      ),
                      Column(
                        key: stickyKey,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total : \$ 200',
                            style: fontSize,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '15 %',
                            style: fontSize,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$ 6',
                            style: fontSize,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1.5,
                    color: blackColorShade1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: fontSize,
                      ),
                      Text(
                        '\$ 202',
                        style: fontSize,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PaymentScreen()));
                      },
                      child: const Text(
                        'Pay Now',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
