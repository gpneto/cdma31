import 'package:flutter/widgets.dart';

abstract class BaseStatelessScreen  extends StatefulWidget {
  String get title;
  IconData get androidIcon;
  IconData get iosIcon;
}