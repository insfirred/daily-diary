class Progress{
  final String id;
  final String date;
  final String progress;

  Progress({
    required this.id,
    required this.date,
    required this.progress
  });

  Map <String,dynamic> toJson()=>{
    'id': id,
    'date': date,
    'progress': progress
  };

  static Progress fromJson(Map<String,dynamic> json) => Progress(
    id: json['id'],
    date: json['date'],
    progress: json['progress']
  );
}