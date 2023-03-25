import 'package:flutter/material.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/models/baseProviderModel/base_provider_model.dart';
import 'package:provider/provider.dart';

class BaseViewModel<T extends BaseProviderModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T provider, Widget child) builder;
  final Function(T) providerReady;

  BaseViewModel({this.builder, this.providerReady});

  @override
  _BaseViewModelState<T> createState() => _BaseViewModelState<T>();
}

class _BaseViewModelState<T extends BaseProviderModel>
    extends State<BaseViewModel<T>> {
  T provider = myLocator<T>();

  @override
  void initState() {
    widget.providerReady(provider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
