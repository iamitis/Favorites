import SearchModel from '../model/SearchModel';
import { CityData, WeatherData, WeatherResult } from '../viewModel/WeatherModel'
import { webview } from '@kit.ArkWeb';
import httpGet from '../util/HttpUtil';
import { http } from '@kit.NetworkKit';
import { promptAction } from '@kit.ArkUI';
import { WeatherItem } from '../view/WeatherItem';
import { AppFontSize, ColorMode } from '../common/constant/ThemeConstants';

@Component
export struct SearchWeather {
  cities: CityData[] = SearchModel.getCityData();
  private cityNames: SelectOption[] = [];
  @State private selectedCity: string = "选择城市";
  @State private selectedIndex: number = -1;
  private addr: string = SearchModel.getWeatherRequestAddr();
  private myKey: string = SearchModel.getWeatherRequestKey();
  @State searchUrl: string = "";
  @State private weatherData: WeatherData = new WeatherData();
  @Consume('colorMode') colorMode: ColorMode;

  aboutToAppear(): void {
    this.cities.forEach((city: CityData) => {
      this.cityNames.push({ value: city.name });
    });
  }

  build() {
    Column({space: 24}) {
      Row({ space: 8 }) {
        Select(this.cityNames)
          .borderRadius(0)
          .fontColor(this.colorMode === ColorMode.LIGHT
            ? $r('app.color.text')
            : $r('app.color.text_dark'))
          .value(this.selectedCity)
          .onSelect((index: number, cityName: string) => {
            this.selectedIndex = index;
            this.selectedCity = cityName;
            this.genSearchSrc();
          })
        Button("查询天气")
          .type(ButtonType.Normal)
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .onClick(() => {
            this.requestWeather();
          })
      }

      WeatherItem({weatherData: this.weatherData})
    }
    .width('100%')
    .height('100%')
    .padding({ top: 16 })
    .justifyContent(FlexAlign.Start)
    .backgroundColor(this.colorMode === ColorMode.LIGHT
      ? $r('app.color.background')
      : $r('app.color.background_dark'))
  }

  genSearchSrc() {
    this.searchUrl = this.addr + "key=" + this.myKey + "&city=" + this.cities[this.selectedIndex].code;
  }

  async requestWeather() {
    if (this.selectedIndex === -1) {
      promptAction.showToast({
        message: "请选择城市"
      });
      return;
    }

    try {
      let result = await httpGet(this.searchUrl);
      if (result && result.responseCode === http.ResponseCode.OK) {
        let weatherResult: WeatherResult = await JSON.parse(result.result.toString());
        this.weatherData = weatherResult.lives[0];
      }
    } catch (error) {
      promptAction.showToast({
        message: "request failed"
      });
    }
  }
}

@Extend(Text) function TextStyle(colorMode: ColorMode) {
  .fontColor(colorMode === ColorMode.LIGHT
    ? $r('app.color.text')
    : $r('app.color.text_dark'))
  .fontSize(AppFontSize.LARGE)
}
