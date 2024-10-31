import { AppFontSize, ColorMode } from '../common/constant/ThemeConstants';
// import PreferenceModel from '../model/PreferenceModel';
import { Blogs } from './Blogs'
import { Categories } from './Categories'
import { Profile } from './Profile'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @Provide('colorMode') colorMode: ColorMode = ColorMode.LIGHT;

  // async aboutToAppear() {
    // await PreferenceModel.getPreferencesModelFromStorage();
    //
    // PreferenceModel.getColorMode().then((res) => {
    //   if (res) {
    //     this.colorMode = res;
    //   }
    // })
  // }

  build() {
    Tabs() {
      // TabContent() {
      //   Profile()
      // }.tabBar('Profile')

      TabContent() {
        Categories()
      }
      .tabBar(this.tabBuilder('分类', 0))

      TabContent() {
        Blogs()
      }
      .tabBar(this.tabBuilder('文章', 1))
    }
    .barBackgroundColor(this.colorMode === ColorMode.LIGHT
      ? $r('app.color.background_card')
      : $r('app.color.background_card_dark'))
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }

  @Builder
  tabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? $r('app.color.text') : $r('app.color.text_shallow'))
        .fontSize(AppFontSize.XLARGE)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}