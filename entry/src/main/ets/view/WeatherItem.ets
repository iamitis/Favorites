import { AppFontSize, ColorMode } from '../common/constant/ThemeConstants';
import { WeatherData } from '../viewModel/WeatherModel'

@Component
export struct WeatherItem {
  @Prop weatherData: WeatherData;
  @Consume('colorMode') colorMode: ColorMode;

  build() {
    Column({ space: 8 }) {
      if (this.weatherData.weather !== '') {
        Text(this.weatherData.weather)
          .TextStyle(this.colorMode)
        Text("气温: " + this.weatherData.temperature + "℃")
          .TextStyle(this.colorMode)
        Text("湿度: " + this.weatherData.humidity + "%")
          .TextStyle(this.colorMode)
      }
    }
  }
}

@Extend(Text)
function TextStyle(colorMode: ColorMode) {
  .fontColor(colorMode === ColorMode.LIGHT
    ? $r('app.color.text')
    : $r('app.color.text_dark'))
  .fontSize(AppFontSize.LARGE)
}
