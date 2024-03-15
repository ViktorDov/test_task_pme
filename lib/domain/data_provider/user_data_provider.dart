import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_pme/domain/entity/pulse.dart';

class UserDataProvider {
  static const _pulseKey = 'pulse';
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<void> savePulseData(List<Pulse> pulses) async {
    final sharedPreferences = await _sharedPreferences;
    final jsonPulses = pulses.map((pulse) => pulse.toJson()).toList();
    final jsonString = json.encode(jsonPulses);
    sharedPreferences.setString(_pulseKey, jsonString);
  }

  Future<List<Pulse>> getPulseData() async {
    final sharedPreferences = await _sharedPreferences;
    final jsonString = sharedPreferences.getString(_pulseKey);
    if (jsonString != null) {
      final jsonPulses = json.decode(jsonString) as List<dynamic>;
      return jsonPulses.map((jsonPulse) => Pulse.fromJson(jsonPulse)).toList();
    }
    return [];
  }
}
