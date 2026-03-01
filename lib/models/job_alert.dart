class JobAlert {
  final String id;
  final String title;
  final String keyword;
  final String userId;

  JobAlert({
    required this.id,
    required this.title,
    required this.keyword,
    required this.userId,
  });

  factory JobAlert.fromMap(String id, Map<String, dynamic> data) {
    return JobAlert(
      id: id,
      title: data['title'],
      keyword: data['keyword'],
      userId: data['userId'],
    );
  }
}