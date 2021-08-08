class Joke {
  final String title;
  final String content;

  Joke({
    required this.title,
    required this.content,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
