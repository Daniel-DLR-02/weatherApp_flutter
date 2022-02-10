import 'package:flutter/material.dart';

abstract class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage(this.leading, this.title);

  final Widget leading;
  final String title;
}
