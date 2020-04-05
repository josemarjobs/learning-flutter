class Report {
  final int temp;
  final String wax;
  final String line;
  final String timeStamp;

  Report({
    this.temp,
    this.wax,
    this.line,
    this.timeStamp,
  });

  factory Report.fromJson(Map<String, dynamic> data) {
    return Report(
      temp: int.parse(data['temp']),
      wax: data['wax'],
      timeStamp: data['timeStamp'],
      line: data['line'],
    );
  }
}
