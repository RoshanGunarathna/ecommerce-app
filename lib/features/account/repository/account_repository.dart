import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountRepositoryProvider = Provider(
  (ref) => AccountRepository(),
);

class AccountRepository {}
