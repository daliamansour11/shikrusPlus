



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextMethods on BuildContext {

  ThemeData get appTheme => Theme.of(this);

}