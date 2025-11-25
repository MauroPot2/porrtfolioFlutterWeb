class Project {
  final String id;
  final String title;
  final String description;
  final String link;

  final String? subtitle;
  final String? descriptionLong;
  final List<String>? features;
  final String? architecture;
  final String? snippet;
  final List<String>? images;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    this.subtitle,
    this.descriptionLong,
    this.features,
    this.architecture,
    this.snippet,
    this.images,
  });
}
