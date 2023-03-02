import 'package:flutter/material.dart';

import 'global.dart';


class OptionModel {
  final String? id;
  final String? title;
  final String? type;

  OptionModel({
    @required this.id,
    @required this.title,
    this.type = '',
  });

  factory OptionModel.fromJson(Map datas) {
    return OptionModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      title: GlobalEntity.dataFilter(datas['name_fa'].toString()),
    );
  }
}
