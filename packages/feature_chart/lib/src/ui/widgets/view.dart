import 'package:feature_chart/src/ui/bloc/bloc.build.dart';
import 'package:feature_chart/src/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartBloc>(
      create: (_) => GetIt.I<ChartBloc>()..add(const ChartEvent.load()),
      child: const ChartWidget(),
    );
  }
}
