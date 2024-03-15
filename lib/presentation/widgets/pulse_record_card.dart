import 'package:flutter/material.dart';

class PulseRecordCard extends StatelessWidget {
  final String date;
  final String time;
  final String systolic;
  final String diastolic;
  final String pulse;
  const PulseRecordCard({
    super.key,
    required this.date,
    required this.time,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  systolic,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  diastolic,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: 2,
            color: Colors.green[300],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  '$time , $date',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  'Pulse: $pulse',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
