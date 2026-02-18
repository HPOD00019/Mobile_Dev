
import 'package:flutter/material.dart';
import 'package:mobile_dev/pages/desk_page.dart';
import 'package:mobile_dev/pages/temp_dev/development.dart';
import 'package:mobile_dev/pages/temp_dev/alexiy.dart';
import 'package:mobile_dev/pages/temp_dev/artyom.dart';
import 'package:mobile_dev/pages/temp_dev/maxim.dart';
import 'package:mobile_dev/pages/temp_dev/misha.dart';

enum Pages { artyom, maxim, misha, alexiy, devPage, deskPage }

final Map<Pages, Widget> pages = {
  Pages.devPage: DevPage(),
  Pages.artyom: ArtyomWidgets(),
  Pages.maxim: MaximWidgets(),
  Pages.misha: MishaWidgets(),
  Pages.alexiy: AlexiyWidgets(),
  Pages.deskPage: DeskPage(),
};

final Map<Pages, Widget> iconViews = {
  Pages.artyom: NavigationDestination(
    icon: Icon(Icons.self_improvement),
    label: 'Artyom',
    tooltip: '',
  ),
  Pages.maxim: NavigationDestination(
    icon: Icon(Icons.blur_on),
    label: 'Maxim',
    tooltip: '',
  ),
  Pages.misha: NavigationDestination(
    icon: Icon(Icons.storm_rounded),
    label: 'Misha',
    tooltip: '',
  ),
  Pages.alexiy: NavigationDestination(
    icon: Icon(Icons.sports_martial_arts),
    label: 'Alexiy',
    tooltip: '',
  ),
  Pages.deskPage: NavigationDestination(
    icon: Icon(Icons.preview),
    label: 'Desk Page',
    tooltip: '',
  ),
};
