import 'package:flutter/material.dart';

class MainViewProvider extends ChangeNotifier{

int _pageIndex= 0;
int get pageIndex=>_pageIndex;

void SetPageValue(int value){
  _pageIndex=value;
  notifyListeners();
}




}