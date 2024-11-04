import { AppFontSize, ColorMode } from '../common/constant/ThemeConstants';
import PreferenceModel from '../model/PreferenceModel';
import { SearchWeather } from './Search'
import { Categories } from './Categories'
import { Profile } from './Profile'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @Provide('colorMode') colorMode: ColorMode = ColorMode.LIGHT;
  @State colorIcon: Resource = $r('sys.symbol.sun_min');

  aboutToAppear() {
    PreferenceModel.getPreferencesModelFromStorage();

    this.colorMode = PreferenceModel.getColorMode();
    this.colorIcon = this.colorMode === ColorMode.DARK
      ? $r('sys.symbol.moon')
      : $r('sys.symbol.sun')
  }

  build() {
    Stack() {
      Tabs() {
        // TabContent() {
        //   Profile()
        // }.tabBar('Profile')

        TabContent() {
          Categories()
        }
        .tabBar(this.tabBuilder('分类', 0, $r('sys.symbol.list_bullet')))

        TabContent() {
          SearchWeather()
        }
        .tabBar(this.tabBuilder('查询', 1, $r('sys.symbol.magnifyingglass')))
      }
      .height('100%')
      .barBackgroundColor(this.colorMode === ColorMode.LIGHT
        ? $r('app.color.background_card')
        : $r('app.color.background_card_dark'))
      .onChange((index: number) => {
        this.currentIndex = index;
      })

      Button({ type: ButtonType.Circle }) {
        Text() {
          SymbolSpan(this.colorIcon)
        }
        .fontSize(AppFontSize.XLARGE)
        .fontColor(this.colorMode === ColorMode.LIGHT
          ? $r('app.color.text')
          : $r('app.color.text_dark'))
      }
      .position({ bottom: 24, right: 20 })
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        if (this.colorMode === ColorMode.LIGHT) {
          PreferenceModel.changeColorMode(ColorMode.DARK);
          this.colorMode = ColorMode.DARK;
          this.colorIcon = $r('sys.symbol.moon');
        } else {
          PreferenceModel.changeColorMode(ColorMode.LIGHT);
          this.colorMode = ColorMode.LIGHT;
          this.colorIcon = $r('sys.symbol.sun');
        }
      })
    }
    .height('100%')
  }

  @Builder
  tabBuilder(title: string, targetIndex: number, icon?: Resource) {
    Column() {
      Row({space: 8}) {
        Text() {
          SymbolSpan(icon)
        }
        .fontColor(this.currentIndex === targetIndex
          ? this.colorMode === ColorMode.LIGHT
            ? $r('app.color.text')
            : $r('app.color.text_dark')
          : this.colorMode === ColorMode.LIGHT
            ? $r('app.color.text_shallow')
            : $r('app.color.text_shallow_dark'))
        .fontSize(AppFontSize.XLARGE)
        .fontWeight(FontWeight.Bold)

        Text(title)
          .fontColor(this.currentIndex === targetIndex
            ? this.colorMode === ColorMode.LIGHT
              ? $r('app.color.text')
              : $r('app.color.text_dark')
            : this.colorMode === ColorMode.LIGHT
              ? $r('app.color.text_shallow')
              : $r('app.color.text_shallow_dark'))
          .fontSize(AppFontSize.XLARGE)
          .fontWeight(FontWeight.Bold)
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}