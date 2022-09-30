import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:foodtalk/view_models/food_provider.dart';

List<SingleChildWidget> providersList = [
  ChangeNotifierProvider(create: (_) => FoodProvider()),
];
