class Config {
  final String authlibLink;
  final String jar;
  final List<dynamic> params;

  static const defaultAuthlibLink = 'http://localhost:1370/authlib';
  static const defaultJar = 'minecraft_server.jar';

  Config(this.authlibLink, this.jar, this.params);

  Config.getDefault() : this(defaultAuthlibLink, defaultJar, []);

  Config.fromJson(Map<String, dynamic> json)
      : this(json['authlibLink'] ?? defaultAuthlibLink,
            json['jar'] ?? defaultJar, json['params'] ?? []);

  Map<String, dynamic> toJson() =>
      {'authlibLink': authlibLink, 'jar': jar, 'params': params};
}
