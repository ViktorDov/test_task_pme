import 'dart:convert';

class Pulse {
  final String date;
  final String time;
  final String systolic;
  final String diastolic;
  final String pulse;
  Pulse({
    required this.date,
    required this.time,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
  });

  Pulse copyWith({
    int? id,
    String? date,
    String? time,
    String? systolic,
    String? diastolic,
    String? pulse,
  }) {
    return Pulse(
      date: date ?? this.date,
      time: time ?? this.time,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'time': time,
      'systolic': systolic,
      'diastolic': diastolic,
      'pulse': pulse,
    };
  }

  factory Pulse.fromMap(Map<String, dynamic> map) {
    return Pulse(
      date: map['date'] as String,
      time: map['time'] as String,
      systolic: map['systolic'] as String,
      diastolic: map['diastolic'] as String,
      pulse: map['pulse'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pulse.fromJson(String source) =>
      Pulse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pulse(date: $date, time: $time, systolic: $systolic, diastolic: $diastolic, pulse: $pulse)';
  }
}
