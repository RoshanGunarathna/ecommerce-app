import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

import '../../../core/common/controller/common_get_category_controller.dart';
import '../../../core/common/widgets/search.dart';
import '../../../core/palette.dart';
import '../../../model/category_model.dart';
import '../../home/widgets/bottom_bar.dart';

import '../controller/category_controller.dart';
import '../widgets/productStreamBuilder.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenConsumerState();
}

class _CategoryScreenConsumerState extends ConsumerState<CategoryScreen> {
  final _searchController = TextEditingController();

  void backtoHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  //for category part
  List<CategoryModel> _categoryList = [];
  List<String> _categoryListNameStrings = ["All"];
  List<Widget> _pageList = [
    ProductStramBuilder(),
  ];

  void refreshCategoryList() async {
    final isOver = await ref
        .read(categoryControllerProvider.notifier)
        .getCategoryData(context);

    if (isOver) {
      _categoryList = await ref.read(categoryProvider)!;

      setState(() {
        _categoryListNameStrings
            .addAll(_categoryList.map((e) => e.name).toList());
        _pageList.addAll(_categoryList
            .map((e) => ProductStramBuilder(
                  categoryName: e.name,
                ))
            .toList());
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshCategoryList();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 50),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: backtoHome,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: blackColorShade1,
                  size: 35,
                ),
              ),
              title: const Text(
                "Categories",
                style: TextStyle(color: blackColorShade1, fontSize: 25),
              ),
              elevation: 0,
            ),
            Search(textEditingController: _searchController),
          ],
        ),
      ),
      body: _categoryListNameStrings.length > 1
          ? TitleScrollNavigation(
              identiferStyle: const NavigationIdentiferStyle(
                  color: blackColor, position: IdentifierPosition.topAndRight),
              showIdentifier: true,
              barStyle: const TitleNavigationBarStyle(
                  style: TextStyle(fontSize: 15),
                  elevation: 0,
                  activeColor: blackColor,
                  padding: EdgeInsets.all(3),
                  spaceBetween: 30),
              titles: _categoryListNameStrings,
              pages: _pageList,
            )
          : const SizedBox(),
    );
  }
}
