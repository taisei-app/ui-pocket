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
      body: const Column(
        children: [
          _CustomCalendar(),
          Spacer(),
          _ButtonSection(),
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
  // 本日の日付
  late final DateTime today;
  // 最終日（本日の日付を含め60日間）
  late final DateTime lastDay;
  // 選択中の日付（初期値は本日の日付）
  late DateTime focusedDay;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    focusedDay = today;
    lastDay = today.add(const Duration(days: 59));
  }

  @override
  Widget build(BuildContext context) {
    final nextMonthFirstDay =
        DateTime(focusedDay.year, focusedDay.month + 1, 1);
    final prevMonthFirstDay =
        DateTime(focusedDay.year, focusedDay.month - 1, 1);

    final enableMoveNextMonth = nextMonthFirstDay.isBefore(lastDay) ||
        nextMonthFirstDay.isAtSameMomentAs(lastDay);
    final enableMovePrevMonth = prevMonthFirstDay.isAfter(today) ||
        prevMonthFirstDay.isAtSameMomentAs(today);
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
      headerStyle: HeaderStyle(
        // 2 weeksボタンを非表示
        formatButtonVisible: false,
        leftChevronIcon: Icon(
          Icons.arrow_back_ios_rounded,
          color: enableMovePrevMonth ? Colors.black : Colors.grey,
          size: 20,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios_rounded,
          color: enableMoveNextMonth ? Colors.black : Colors.grey,
          size: 20,
        ),
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
      onPageChanged: (selectedDay) {
        setState(() {
          focusedDay = selectedDay;
        });
      },
      selectedDayPredicate: (day) => isSameDay(day, focusedDay),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (_, day) => Center(
          child: Text(
            "${day.year}年 ${day.month}月",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        selectedBuilder: (context, day, focusedDay) => Container(
          margin: const EdgeInsets.all(0.5),
          alignment: Alignment.center,
          color: Colors.black,
          child: Text(
            day.day.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        todayBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
          lastDay: lastDay,
        ),
        defaultBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
          lastDay: lastDay,
        ),
        disabledBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
          lastDay: lastDay,
        ),
        outsideBuilder: (_, day, focusedDay) => _CustomCell(
          today: today,
          day: day,
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
  });

  // 本日の日付
  final DateTime today;

  // 最終日（本日の日付を含め60日間）
  final DateTime lastDay;

  // 各セルの日付
  final DateTime day;

  // 本日より前の日付か
  bool get isBeforeToday => day.isBefore(
        DateTime(
          today.year,
          today.month,
          today.day,
        ),
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
      color: Colors.white,
      child: Text(
        day.day.toString(),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: (isBeforeToday || isAfterLastDay ? Colors.grey : Colors.black),
        ),
      ),
    );
  }
}

// 絞り込みボタン
class _ButtonSection extends StatelessWidget {
  const _ButtonSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            onPressed: () {
              // 日付絞り込みボタン押下時の処理
              // focusedDayで絞り込みを行う
            },
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
    );
  }
}
