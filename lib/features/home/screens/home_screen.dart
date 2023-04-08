import 'package:ecommerce_app/features/auth/controller/auth_controller.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controller/common_get_category_controller.dart';
import '../../../core/common/controller/common_get_product_controller.dart';
import '../../../model/category_model.dart';

import '../../categories/controller/category_controller.dart';

import '../widgets/carouselFutureBuilder.dart';
import '../widgets/productStreamBuilder.dart';
import '../widgets/search.dart';

final currentTimeProvider = StreamProvider.autoDispose<DateTime>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
});

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<HomeScreen> {
  //for category part
  List<CategoryModel> _categoryList = [];

  final List<Widget> _pageList = [
    ProductStramBuilder(),
  ];

  void refreshCategoryList() async {
    final isOver = await ref
        .read(categoryControllerProvider.notifier)
        .getCategoryData(context);

    if (isOver) {
      _categoryList = await ref.read(categoryProvider)!;

      _pageList.addAll(_categoryList
          .map((e) => ProductStramBuilder(
                category: e.name,
              ))
          .toList());
    }
    refresh();
  }

  void refresh() {
    setState(() {});
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
    final userData = ref.watch(userProvider);
    final UserModel user = userData ??
        UserModel(
            id: '-',
            name: 'guest',
            address: '',
            email: '',
            photoUrl: "",
            cart: []);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Search(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const CarouselFutureBuilder(),
              const SizedBox(
                height: 10,
              ),
              _pageList.length > 1
                  ? Column(children: _pageList)
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
