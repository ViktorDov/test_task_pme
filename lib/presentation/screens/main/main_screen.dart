import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_pme/domain/entity/pulse.dart';
import 'package:test_task_pme/presentation/screens/history/history_screen.dart';
import 'package:test_task_pme/presentation/screens/add_pulse_records/add_pulse_records.dart';
import '../../constats/app_colors.dart';
import '../../widgets/pulse_record_card.dart';
import '../cubit/pulse_records_cubit.dart';

class MainScreen extends StatefulWidget {
  static const path = '/';
  static const name = 'mainScreen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        title: const Text('Pulse Tracker'),
      ),
      body: const Column(
        children: [
          MainScreenBody(),
          ButtonFormWidget(),
        ],
      ),
    );
  }
}

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({super.key});

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PulseRecordsCubit, PulseRecordsState>(
      builder: (context, state) {
        switch (state.status) {
          case PulseRecordsStatus.empty:
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No records yet'),
              ),
            );
          case PulseRecordsStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PulseRecordsStatus.loaded:
            final List<Pulse> lastThreePulses = state.pulseRecords.length > 3
                ? state.pulseRecords.sublist(state.pulseRecords.length - 3)
                : state.pulseRecords;
            return state.pulseRecords.isEmpty
                ? const Center(
                    child: Text('No records yet'),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: ListView.builder(
                      itemCount: lastThreePulses.length,
                      itemBuilder: (context, index) {
                        return PulseRecordCard(
                          date: lastThreePulses[index].date,
                          time: lastThreePulses[index].time,
                          systolic: lastThreePulses[index].systolic,
                          diastolic: lastThreePulses[index].diastolic,
                          pulse: lastThreePulses[index].pulse,
                        );
                      },
                    ),
                  );
        }
      },
    );
  }
}

class ButtonFormWidget extends StatelessWidget {
  const ButtonFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.green[400],
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            context.goNamed(HistoryScreen.name);
          },
          child: const Text('View all records'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.green[400],
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            context.goNamed(AddPulseRecords.name);
          },
          child: const Text('Add new record'),
        ),
      ],
    );
  }
}
