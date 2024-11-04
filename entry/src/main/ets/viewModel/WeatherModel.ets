export class CityData {
  name: string = '';
  code: string = '';

  constructor(name: string, code: string) {
    this.name = name;
    this.code = code;
  }
}

export class WeatherData {
  weather: string = '';
  temperature: string = '';
  humidity: string = '';
}

export class WeatherResult {
  lives: WeatherData[] = [];
}