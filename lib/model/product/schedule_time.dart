
class ScheduleTime {
  final bool booking;
  final String schedule;
  final int timePerSession;
  ScheduleTime({
    required this.booking,
    required this.schedule,
    required this.timePerSession,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'booking': booking,
      'schedule': schedule,
      'timePerSession': timePerSession,
    };
  }

  factory ScheduleTime.fromMap(Map<String, dynamic> map) {
    return ScheduleTime(
      booking: map['booking'] as bool,
      schedule: map['schedule'] as String,
      timePerSession: map['timePerSession'].toInt() as int,
    );
  }

  @override
  String toString() => 'ScheduleTime(booking: $booking, schedule: $schedule, timePerSession: $timePerSession)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ScheduleTime &&
      other.booking == booking &&
      other.schedule == schedule &&
      other.timePerSession == timePerSession;
  }
}