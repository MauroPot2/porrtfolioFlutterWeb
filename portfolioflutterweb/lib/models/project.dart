class Project {
  final String title;
  final String description;
  final String link;
  final String? image;

  Project({
    required this.title,
    required this.description,
    required this.link,
    this.image,
  });
}
