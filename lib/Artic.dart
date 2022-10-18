class Artic {
  String author, title, description, url, urlToImage, content, publishedAt;

  Artic(this.author, this.title, this.description, this.url, this.urlToImage,
      this.content, this.publishedAt);

  Artic.fromJson(Map<String, dynamic> map) {
    this.author = map['author'];
    this.title = map['title'];
    this.description = map['description'];
    this.url = map['url'];
    this.urlToImage = map['urlToImage'];
    this.content = map['content'];
    this.publishedAt = map['publishedAt'];
  }
}
