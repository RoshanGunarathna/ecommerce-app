//user provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';

final cartSelectedItemProvider =
    StateProvider<List<ProductModel>?>((ref) => null);
