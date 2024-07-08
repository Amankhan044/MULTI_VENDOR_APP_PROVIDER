import 'package:flutter/material.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/account_view.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/cart_view.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/category_view.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/home_view.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/search_view.dart';
import 'package:multi_vendor_app_provider/views/buyers/nav_screen/store_view.dart';

class MainViewProvider extends ChangeNotifier{

int _pageIndex= 0;
int get pageIndex=>_pageIndex;

List<Widget> _listPages=[HomeView(),CategoryView(),StoreView(),CartView(),SearchView(),AccountView()];
List<Widget> get listPages=>_listPages;

void setPageValue(int value){
  _pageIndex=value;
  notifyListeners();
}




}