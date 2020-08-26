import 'package:flutter_bluetooth_app/model/weather.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super();
   @override
  List<Object> get props => [const []];
}

class WeatherEmpty extends WeatherState {
 
}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({@required this.weather})
      : assert(weather != null),
        super([weather]);
}

class WeatherError extends WeatherState {
  final int errorCode;

  WeatherError({@required this.errorCode})
      : assert(errorCode != null),
        super([errorCode]);
}
