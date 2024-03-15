import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_pme/presentation/constats/app_colors.dart';
import 'package:test_task_pme/presentation/screens/main/main_screen.dart';
import 'package:test_task_pme/presentation/widgets/custom_numpicker.dart';

import '../cubit/pulse_records_cubit.dart';

class AddPulseRecords extends StatefulWidget {
  static const path = '/AddPulseRecords';
  static const name = 'pulseRecords';
  const AddPulseRecords({super.key});

  @override
  State<AddPulseRecords> createState() => _AddPulseRecordsState();
}

class _AddPulseRecordsState extends State<AddPulseRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.goNamed(MainScreen.name);
            },
          ),
          backgroundColor: AppColors.backgroundWhite,
          title: const Text('Pulse Tracker'),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PulseRecordsBody(),
              DateTimeBlockWidget(),
              SaveRecordsButton(),
            ],
          ),
        ));
  }
}

class PulseRecordsBody extends StatefulWidget {
  const PulseRecordsBody({super.key});

  @override
  State<PulseRecordsBody> createState() => _PulseRecordsBodyState();
}

class _PulseRecordsBodyState extends State<PulseRecordsBody> {
  var sysolicValue = 50;
  var diastolicValue = 50;
  var pullseValue = 50;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomNumPicker(
          titleType: 'Systolic',
          type: 'mmHg',
          value: sysolicValue,
          onChanged: (newValue) {
            setState(() {
              sysolicValue = newValue;
              context
                  .read<PulseRecordsCubit>()
                  .systolicValueChanged(sysolicValue);
            });
          },
        ),
        const SizedBox(width: 20),
        CustomNumPicker(
          titleType: 'Diastolic',
          type: 'mmHg',
          value: diastolicValue,
          onChanged: (newValue) {
            setState(() {
              diastolicValue = newValue;
              context
                  .read<PulseRecordsCubit>()
                  .diastolicValueChanged(diastolicValue);
            });
          },
        ),
        const SizedBox(width: 20),
        CustomNumPicker(
          titleType: 'Pulse',
          type: 'BMP',
          value: pullseValue,
          onChanged: (newValue) {
            setState(() {
              pullseValue = newValue;
              context.read<PulseRecordsCubit>().pulseValueChanged(pullseValue);
            });
          },
        ),
      ],
    );
  }
}

class DateTimeBlockWidget extends StatefulWidget {
  const DateTimeBlockWidget({super.key});

  @override
  State<DateTimeBlockWidget> createState() => _DateTimeBlockWidgetState();
}

class _DateTimeBlockWidgetState extends State<DateTimeBlockWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date & Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              DatePickerFormWidget(),
              SizedBox(width: 40),
              TimePickerFormWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class TimePickerFormWidget extends StatefulWidget {
  const TimePickerFormWidget({super.key});

  @override
  State<TimePickerFormWidget> createState() => _TimePickerFormWidgetState();
}

class _TimePickerFormWidgetState extends State<TimePickerFormWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();
  final timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: TextField(
        readOnly: true,
        controller: timeController,
        decoration: const InputDecoration(
            icon: Icon(Icons.punch_clock_outlined), labelText: "Set Time"),
        onTap: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            initialEntryMode: TimePickerEntryMode.dialOnly,
          );
          if (timeOfDay != null) {
            setState(
              () {
                selectedTime = timeOfDay;
                timeController.text = selectedTime.format(context);
                context
                    .read<PulseRecordsCubit>()
                    .timeValueChanged(timeController.text);
              },
            );
          }
        },
      ),
    );
  }
}

class DatePickerFormWidget extends StatefulWidget {
  const DatePickerFormWidget({super.key});

  @override
  State<DatePickerFormWidget> createState() => _DatePickerFormWidgetState();
}

class _DatePickerFormWidgetState extends State<DatePickerFormWidget> {
  final TextEditingController textDateController = TextEditingController();
  var time = TimeOfDay.fromDateTime(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: TextField(
        controller: textDateController,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            textDateController.text = pickedDate.toString().split(' ')[0];
            context
                .read<PulseRecordsCubit>()
                .dateValueChanged(textDateController.text);
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }
}

class SaveRecordsButton extends StatelessWidget {
  const SaveRecordsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<PulseRecordsCubit>().addPulseRecord();
        context.goNamed(MainScreen.name);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green[400],
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        textStyle: const TextStyle(fontSize: 14),
      ),
      child: const Text('Save Records'),
    );
  }
}
