import DataModel from './DataModel'

export default class SearchModel {

  public static getCityData() {
    return DataModel.CITIES;
  }

  public static getWeatherRequestAddr() {
    return DataModel.WEATHER_REQUEST_ADDR;
  }

  public static getWeatherRequestKey() {
    return DataModel.WEATHER_REQUEST_KEY;
  }

}