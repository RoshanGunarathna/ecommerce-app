// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/palette.dart';
import '../../../model/product.dart';
import '../controller/search_controller.dart';
import '../widgets/searched_product.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const routeName = '/search-screen';
  final TextEditingController searchController;
  const SearchScreen({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenConsumerState();
}

class _SearchScreenConsumerState extends ConsumerState<SearchScreen> {
  String name = "";

  void navigateToBackScreen() {
    widget.searchController.text = "";
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          navigateToBackScreen();
          return false;
        },
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          autofocus: true,
                          controller: widget.searchController,
                          cursorColor: blackColor,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                            prefixIcon: InkWell(
                              onTap: () => navigateToBackScreen(),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                ),
              ),
            ),
            body: ref.watch(searchProviderStream).when(
                data: (snapshot) => whenData(snapshot),
                error: (error, stackTrace) => whenError(error),
                loading: () => whenLoading())));
  }

  //when error
  Widget whenError(dynamic error) {
    return Center(
      child: Text('Something went wrong! ${error}'),
    );
  }

  //when data
  Widget whenData(dynamic snapshot) {
    List<ProductModel> suggestionList = snapshot;

    final data = snapshot.runtimeType;

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                final product = suggestionList[index];
                return widget.searchController.text.isEmpty
                    ? const SizedBox()
                    : product.name.toLowerCase().startsWith(
                            widget.searchController.text.toLowerCase())
                        ? GestureDetector(
                            onTap: () {},
                            child: SearchedProduct(
                              product: product,
                              searchingTextLength:
                                  widget.searchController.text.length,
                            ),
                          )
                        : const SizedBox();
              }),
        ),
      ],
    );
  }

  //when loading
  Widget whenLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator.adaptive(),
          SizedBox(
            height: 20,
          ),
          Text('We are Loading..'),
        ],
      ),
    );
  }
}
