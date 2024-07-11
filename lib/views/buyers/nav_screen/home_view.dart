import 'package:flutter/material.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/widgets/banner_widget.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/widgets/search_input_widget.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/widgets/welcome_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      WelcomeText(),
      SizedBox(
        height: 14,
      ),
      SearchInputWidget(),
      BannerWidget()
    ]);
  }
}
