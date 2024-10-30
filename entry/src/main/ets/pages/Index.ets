import { AppFontSize } from '../common/constants/ThemeConstants';
import { Blogs } from './Blogs'
import { Categories } from './Categories'
import { Profile } from './Profile'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

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
    .barBackgroundColor($r('app.color.background_card'))
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }

  @Builder tabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? $r('app.color.text') : $r('app.color.text_gray'))
        .fontSize(AppFontSize.XLARGE)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

}