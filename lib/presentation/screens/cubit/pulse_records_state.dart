part of 'pulse_records_cubit.dart';

enum PulseRecordsStatus { empty, loading, loaded }

class PulseRecordsState extends Equatable {
  final PulseRecordsStatus status;
  final List<Pulse> pulseRecords;
  final int systolicValue;
  final int diastolicValue;
  final int pulseValue;
  final String time;
  final String date;
  const PulseRecordsState({
    this.status = PulseRecordsStatus.empty,
    this.pulseRecords = const [],
    this.systolicValue = 50,
    this.diastolicValue = 50,
    this.pulseValue = 50,
    this.time = '00:00',
    this.date = '00.00.0000',
  });

  @override
  List<Object> get props => [
        pulseRecords,
        systolicValue,
        diastolicValue,
        pulseValue,
        time,
        date,
        status
      ];

  PulseRecordsState copyWith({
    PulseRecordsStatus? status,
    List<Pulse>? pulseRecords,
    int? systolicValue,
    int? diastolicValue,
    int? pulseValue,
    String? time,
    String? date,
  }) {
    return PulseRecordsState(
      status: status ?? this.status,
      pulseRecords: pulseRecords ?? this.pulseRecords,
      systolicValue: systolicValue ?? this.systolicValue,
      diastolicValue: diastolicValue ?? this.diastolicValue,
      pulseValue: pulseValue ?? this.pulseValue,
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }
}
