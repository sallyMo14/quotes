class Pict {
  String? provider;
  String? license;
  String? terms;
  String? url;
  Size? size;

  Pict({this.provider, this.license, this.terms, this.url, this.size});

  Pict.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    license = json['license'];
    terms = json['terms'];
    url = json['url'];
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['license'] = this.license;
    data['terms'] = this.terms;
    data['url'] = this.url;
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    return data;
  }
}

class Size {
  int? height;
  int? width;

  Size({this.height, this.width});

  Size.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['width'] = this.width;
    return data;
  }
}
