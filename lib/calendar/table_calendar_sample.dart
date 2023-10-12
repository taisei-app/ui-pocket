import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarSample extends StatelessWidget {
  const TableCalendarSample({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "勤務日",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: _CustomCalendar(),
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    "この日付で絞り込む",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// カレンダーセクション
class _CustomCalendar extends StatefulWidget {
  const _CustomCalendar();

  @override
  State<_CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<_CustomCalendar> {
  final today = DateTime.now();
  DateTime get lastDay => today.add(const Duration(days: 59));
  late var focusedDay = today;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // 曜日の高さ
      daysOfWeekHeight: 32,
      // 曜日のスタイル
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
        weekendStyle: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
      // ヘッダーのスタイル
      headerStyle: const HeaderStyle(
        // 2 weeksボタンを非表示
        formatButtonVisible: false,
      ),
      // 表示するカレンダーは現在日時から60日間表示
      firstDay: today,
      lastDay: lastDay,
      focusedDay: focusedDay,
      locale: 'ja_JP',
      onDaySelected: (selectDay, _) {
        setState(() {
          focusedDay = selectDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (_, day) {
          return Center(
            child: Text(
              "${day.year}年 ${day.month}月",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
        todayBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
          focusedDay: focusedDay,
          lastDay: lastDay,
        ),
        defaultBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
          focusedDay: focusedDay,
          lastDay: lastDay,
        ),
        disabledBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
          focusedDay: focusedDay,
          lastDay: lastDay,
        ),
        outsideBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
          focusedDay: focusedDay,
          lastDay: lastDay,
        ),
      ),
    );
  }
}

// 各セル
class _CustomCell extends StatelessWidget {
  const _CustomCell({
    required this.today,
    required this.lastDay,
    required this.day,
    required this.focusedDay,
  });

  // 本日の日付
  final DateTime today;

  // 最終日（本日の日付を含め60日間）
  final DateTime lastDay;

  // 各セルの日付
  final DateTime day;

  // 選択中の日付
  final DateTime focusedDay;

  // 選択された日付かどうか
  bool get isFocusedDay =>
      focusedDay.year == day.year &&
      focusedDay.month == day.month &&
      focusedDay.day == day.day;

  // 本日より前の日付か
  bool get isBeforeToday => day.isBefore(
        DateTime(today.year, today.month, today.day),
      );

  // 表示最終日以降の日付か
  bool get isAfterLastDay => day.isAfter(
        DateTime(
          lastDay.year,
          lastDay.month,
          lastDay.day + 1,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.5),
      alignment: Alignment.center,
      color: isFocusedDay ? Colors.black : Colors.white,
      child: Text(
        day.day.toString(),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isFocusedDay
              ? Colors.white
              : (isBeforeToday || isAfterLastDay ? Colors.grey : Colors.black),
        ),
      ),
    );
  }
}
