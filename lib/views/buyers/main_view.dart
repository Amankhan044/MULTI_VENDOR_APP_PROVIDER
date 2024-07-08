import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_app_provider/models/main_view_provider.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewProvider>(builder: (context, value, child) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: value.pageIndex,
          onTap: (v) {
            value.setPageValue(v);
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade900,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/explore.svg',
                width: 20,
              ),
              label: 'CATEGORIES',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/shop.svg',
                width: 20,
              ),
              label: 'STORE',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/cart.svg'),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/account.svg'),
              label: 'ACCOUNT',
            ),
          ],
        ),
        body: value.listPages[value.pageIndex],
      );
    });
  }
}
