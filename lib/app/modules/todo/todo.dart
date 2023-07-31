library todo;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/core/extension.dart';

import '../../data/models/todo_model.dart';
import '../../providers/appstate/appstate_provider.dart';
import '../../providers/todo/todo_provider.dart';
import '../../widgets/widget.dart';

part 'todo_view.dart';
part 'widgets/todo_list_item.dart';
