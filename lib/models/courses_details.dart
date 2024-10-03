class Courses_details {
  Courses_details(
      {this.cost,
      this.courseName,
      this.id,
      // this.endtData,
      this.startData,
      this.teacherName,
      this.teacherid,
      this.courseid,
      this.level,
      this.description,
      this.hours});

  int? id;
  String? courseName;
  String? description;
  int? hours;
  int? level;
  int? cost;
  DateTime? startData;
  //DateTime? endtData;
  String? teacherName;
  int? teacherid;
  int? courseid;

  factory Courses_details.fromJson(Map<String, dynamic> data) {
    return Courses_details(
      id: data["id"],
      teacherid: data["teacherId"],
      courseid: data["courseId"],
      courseName: data["course"]["title"],
      level: data["course"]["level"],
      cost: data["cost"],
      startData: DateTime.tryParse(data["startDate"]),
      // endtData: DateTime.tryParse(data["finishedAt"] ?? "test"),
      //  teacherName: data["teacher"]["name"]
    );
  }
  factory Courses_details.fromJsonAsCourse(Map<String, dynamic> data) {
    return Courses_details(
      id: data["id"],
      courseName: data["title"],
      description: data["description"],
      level: data["level"],
      hours: data["hours"],
    );
  }
}
