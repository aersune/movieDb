

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class NavigateProvider extends ChangeNotifier {
    int pageIndex = 0;

    changePage({required int page}) {
      pageIndex = page;

      notifyListeners();
    }




}