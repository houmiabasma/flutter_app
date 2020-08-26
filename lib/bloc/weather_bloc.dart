import 'package:bloc/bloc.dart';
import 'package:flutter_bluetooth_app/api/http_exception.dart';
import 'package:flutter_bluetooth_app/bloc/weather_event.dart';
import 'package:flutter_bluetooth_app/bloc/weather_state.dart';
import 'package:flutter_bluetooth_app/model/weather.dart';
import 'package:flutter_bluetooth_app/repository/weather_repository.dart';

import 'package:meta/meta.dart';



class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState {
    return WeatherEmpty();
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(
            event.cityName,
            latitude: event.latitude,
            longitude: event.longitude);
        yield WeatherLoaded(weather: weather);
      } catch (exception) {
        print(exception);
        if (exception is HTTPException) {
          yield WeatherError(errorCode: exception.code);
        } else {
          yield WeatherError(errorCode: 500);
        }
      }
    }
  }
}
