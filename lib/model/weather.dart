class WeatherResponse {
  WeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });
  late final Coord coord;
  late final List<Weather> weather;
  late final dynamic base;
  late final Main main;
  late final dynamic? visibility;
  late final Wind wind;
  late final Clouds clouds;
  late final dynamic? dt;
  late final Sys sys;
  late final dynamic? timezone;
  late final dynamic? id;
  late final dynamic name;
  late final dynamic? cod;

  WeatherResponse.fromJson(Map<dynamic, dynamic> json) {
    coord = Coord.fromJson(json['coord']);
    weather =
        List.from(json['weather']).map((e) => Weather.fromJson(e)).toList();
    base = json['base'];
    main = Main.fromJson(json['main']);
    visibility = json['visibility']?.toInt();
    wind = Wind.fromJson(json['wind']);
    clouds = Clouds.fromJson(json['clouds']);
    dt = json['dt']?.toInt();
    sys = Sys.fromJson(json['sys']);
    timezone = json['timezone']?.toInt();
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['coord'] = coord.toJson();
    _data['weather'] = weather.map((e) => e.toJson()).toList();
    _data['base'] = base;
    _data['main'] = main.toJson();
    _data['visibility'] = visibility;
    _data['wind'] = wind.toJson();
    _data['clouds'] = clouds.toJson();
    _data['dt'] = dt;
    _data['sys'] = sys.toJson();
    _data['timezone'] = timezone;
    _data['id'] = id;
    _data['name'] = name;
    _data['cod'] = cod;
    return _data;
  }
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });
  late final double? lon;
  late final double? lat;

  Coord.fromJson(Map<dynamic, dynamic> json) {
    lon = json['lon']?.toDouble();
    lat = json['lat']?.toDouble();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['lon'] = lon;
    _data['lat'] = lat;
    return _data;
  }
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
  late final dynamic? id;
  late final dynamic main;
  late final String description;
  late final dynamic icon;

  Weather.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['main'] = main;
    _data['description'] = description;
    _data['icon'] = icon;
    return _data;
  }
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });
  late final double? temp;
  late final double? feelsLike;
  late final double? tempMin;
  late final double? tempMax;
  late final dynamic? pressure;
  late final dynamic? humidity;

  Main.fromJson(Map<dynamic, dynamic> json) {
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    tempMin = json['temp_min']?.toDouble();
    tempMax = json['temp_max']?.toDouble();
    pressure = json['pressure']?.toInt();
    humidity = json['humidity']?.toInt();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['temp'] = temp;
    _data['feels_like'] = feelsLike;
    _data['temp_min'] = tempMin;
    _data['temp_max'] = tempMax;
    _data['pressure'] = pressure;
    _data['humidity'] = humidity;
    return _data;
  }
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });
  late final double? speed;
  late final dynamic deg;

  Wind.fromJson(Map<dynamic, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg']?.toInt();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['speed'] = speed;
    _data['deg'] = deg;
    return _data;
  }
}

class Clouds {
  Clouds({
    required this.all,
  });
  late final dynamic all;

  Clouds.fromJson(Map<dynamic, dynamic> json) {
    all = json['all'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['all'] = all;
    return _data;
  }
}

class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.message,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });
  late final dynamic? type;
  late final dynamic? id;
  late final double? message;
  late final dynamic country;
  late final dynamic? sunrise;
  late final dynamic? sunset;

  Sys.fromJson(Map<dynamic, dynamic> json) {
    type = json['type']?.toInt();
    id = json['id'];
    message = json['message']?.toDouble();
    country = json['country'];
    sunrise = json['sunrise']?.toInt();
    sunset = json['sunset']?.toInt();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['type'] = type;
    _data['id'] = id;
    _data['message'] = message;
    _data['country'] = country;
    _data['sunrise'] = sunrise;
    _data['sunset'] = sunset;
    return _data;
  }
}
