import 'dart:convert';

class Schedule {
  String? dayname;
  String? endTime;
  String? id;
  String? startTime;
  int? timePerSession;

  Schedule({
    this.dayname,
    this.endTime,
    this.id,
    this.startTime,
    this.timePerSession,
  });

  @override
  String toString() {
    return 'Schedule(dayname: $dayname, endTime: $endTime, id: $id, startTime: $startTime, timePerSession: $timePerSession)';
  }

  factory Schedule.fromMap(Map<String, dynamic> data) => Schedule(
        dayname: data['dayname'] as String?,
        endTime: data['endTime'] as String?,
        id: data['id'] as String?,
        startTime: data['startTime'] as String?,
        timePerSession: data['timePerSession'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'dayname': dayname,
        'endTime': endTime,
        'id': id,
        'startTime': startTime,
        'timePerSession': timePerSession,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Schedule].
  factory Schedule.fromJson(String data) {
    return Schedule.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Schedule] to a JSON string.
  String toJson() => json.encode(toMap());
}
