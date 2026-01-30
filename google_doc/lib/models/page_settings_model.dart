class PageSettingsModel {
  final String size;
  final String orientation;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final String backgroundColor;

  PageSettingsModel({
    required this.size,
    required this.orientation,
    required this.marginTop,
    required this.marginBottom,
    required this.marginLeft,
    required this.marginRight,
    required this.backgroundColor,
  });

  factory PageSettingsModel.fromJson(Map<String, dynamic> json) {
    final margin = json['margin'] ?? {};

    return PageSettingsModel(
      size: json['size'] ?? 'A4',
      orientation: json['orientation'] ?? 'portrait',
      marginTop: (margin['top'] ?? 40).toDouble(),
      marginBottom: (margin['bottom'] ?? 40).toDouble(),
      marginLeft: (margin['left'] ?? 40).toDouble(),
      marginRight: (margin['right'] ?? 40).toDouble(),
      backgroundColor: json['backgroundColor'] ?? '#FFFFFF',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'orientation': orientation,
      'margin': {
        'top': marginTop,
        'bottom': marginBottom,
        'left': marginLeft,
        'right': marginRight,
      },
      'backgroundColor': backgroundColor,
    };
  }
}
