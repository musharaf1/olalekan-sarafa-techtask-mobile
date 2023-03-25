import 'package:flutter/material.dart';
import 'package:tech_task/enums/ui_state_enum.dart';

class BaseProviderModel extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;
  ViewState get state => _state;

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
