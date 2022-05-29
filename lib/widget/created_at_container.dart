import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatedAtContainer extends StatelessWidget {
  final DateTime? dateTime;
  const CreatedAtContainer({Key? key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.yMMMMEEEEd('fr').format(
        dateTime!,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
