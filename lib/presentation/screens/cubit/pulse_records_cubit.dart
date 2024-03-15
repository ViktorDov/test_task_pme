import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_task_pme/domain/data_provider/user_data_provider.dart';

import '../../../../domain/entity/pulse.dart';

part 'pulse_records_state.dart';

class PulseRecordsCubit extends Cubit<PulseRecordsState> {
  PulseRecordsCubit() : super(const PulseRecordsState()) {
    _loadPulseRecords();
  }
  final UserDataProvider _userDataProvider = UserDataProvider();
  Future<void> _loadPulseRecords() async {
    final pulseRecords = await _userDataProvider.getPulseData();
    if (pulseRecords.isEmpty) {
      emit(state.copyWith(status: PulseRecordsStatus.empty));
    } else {
      emit(state.copyWith(
          status: PulseRecordsStatus.loaded, pulseRecords: pulseRecords));
    }
    emit(state.copyWith(pulseRecords: pulseRecords));
  }

  void systolicValueChanged(int value) {
    emit(state.copyWith(systolicValue: value));
  }

  void diastolicValueChanged(int value) {
    emit(state.copyWith(diastolicValue: value));
  }

  void pulseValueChanged(int value) {
    emit(state.copyWith(pulseValue: value));
  }

  void dateValueChanged(String value) {
    emit(state.copyWith(date: value));
  }

  void timeValueChanged(String value) {
    emit(state.copyWith(time: value));
  }

  Future<void> addPulseRecord() async {
    final List<Pulse> tempPulseRecords = List.from(state.pulseRecords);
    final Pulse pulse = Pulse(
      systolic: state.systolicValue.toString(),
      diastolic: state.diastolicValue.toString(),
      pulse: state.pulseValue.toString(),
      date: state.date,
      time: state.time,
    );
    tempPulseRecords.add(pulse);
    await _userDataProvider.savePulseData(tempPulseRecords);
    emit(state.copyWith(pulseRecords: tempPulseRecords));
    _loadPulseRecords();
  }
}
