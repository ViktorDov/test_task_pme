import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_pme/presentation/screens/cubit/pulse_records_cubit.dart';

import '../../constats/app_colors.dart';
import '../../widgets/pulse_record_card.dart';
import '../main/main_screen.dart';

class HistoryScreen extends StatefulWidget {
  static const path = '/historyScreen';
  static const name = 'historyScreen';
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(MainScreen.name);
          },
        ),
        title: const Text('History'),
      ),
      body: const HistoryScreenBody(),
    );
  }
}

class HistoryScreenBody extends StatelessWidget {
  const HistoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PulseRecordsCubit, PulseRecordsState>(
        builder: (context, state) {
      return ListView.builder(
        itemCount: state.pulseRecords.length,
        itemBuilder: (context, index) {
          final pulse = state.pulseRecords[index];
          return PulseRecordCard(
            date: pulse.date,
            time: pulse.time,
            systolic: pulse.systolic,
            diastolic: pulse.diastolic,
            pulse: pulse.pulse,
          );
        },
      );
    });
  }
}
