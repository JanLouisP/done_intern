import 'package:flutter/cupertino.dart';

class ProgressIndicatorProvider extends ChangeNotifier {
  double _progress = 0.0;
  double _maxLength = 220;
  int _maxPageNumber = 5;
  int _currentPage = 0;

  //Only for testing the progressbar, i dont know how many screens/pages you have,
  //so I just have initialized the current page with 4.
  ProgressIndicatorProvider() {
    currentPage = 4;
    updateProgress();
  }

  //Sets the current page. Is needed for progressbar calculation.
  set currentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  //Changes the maxlength of the progressbar.
  set maxLength(double maxLength) {
    _maxLength = maxLength;
    notifyListeners();
  }

  //Sets the max pagenumber. I dont know how many pages you have in your flow.
  set maxPageNumber(int maxPageNumber) {
    _maxPageNumber = maxPageNumber;
    notifyListeners();
  }

  //Sets the progress of the progressbar
  set progress(double progress) {
    _progress = progress;
    notifyListeners();
  }

  //Returns the actual progress of the progressbar
  double get progress {
    return _progress;
  }

  //Returns the current Page.
  int get currentPage {
    return _currentPage;
  }

  //Returns the max number of Pages in the flow.
  int get maxPageNumber {
    return _maxPageNumber;
  }

  //Returns the maxLength of the progressbar.
  double get maxLength {
    return _maxLength;
  }

  //Updates the progressbar dependable on how many pages there are and on which page we are.
  updateProgress() {
    progress = maxLength * (currentPage / maxPageNumber);
  }
}
